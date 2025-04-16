# MoonBit ESP32 Binding

MoonBit ESP32 Binding is a module that provides bindings for ESP32 development using MoonBit. Currently, it includes simple bindings for GPIO and task management. Future updates will expand the bindings and add more features.

## How to Use

Before you begin, make sure you have installed ESP IDF version v5.4.1. You can find the installation instructions [here](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/index.html#installation).

- Use the following command to create a new MoonBit project:
   ```bash
   moon new hello-esp32
   ```

- After entering the `hello-esp32` project directory, activate your ESP IDF development environment and ensure `idf.py` is properly configured and available:
   ```
   $ idf.py --help
   Usage: idf.py [OPTIONS] COMMAND1 [ARGS]... [COMMAND2 [ARGS]...]...
   ```

- Run the following command to update the index and ensure you get the latest version:
   ```bash
   moon update
   ```

- Add the ESP32 support package:
   ```bash
   moon add moonbitlang/esp32
   ```
   This command will automatically generate a template project `.moonbit_esp32`, configure the ESP IDF toolchain path, and generate a `Makefile`.

- Use the MoonBit ESP32 Binding to blink an LED:
    First, import the relevant packages in `src/main/moon.pkg.json`:
    ```json
    "import": [
        "moonbitlang/esp32/ctypes",
        "moonbitlang/esp32/components/gpio",
        "moonbitlang/esp32/components/task"
    ],
    ```
    Then write the following code in `src/main/main.mbt`:
    ```moonbit
    ///|
    const LED_GPIO_PIN = 12
    
    ///|
    pub fn moonbit_main() -> Unit {
      let _ = @gpio.gpio_config?(
        pin_bit_mask=1UL << LED_GPIO_PIN,
        mode=@gpio.GPIO_MODE_OUTPUT,
        pull_up_en=@gpio.GPIO_PULLUP_ENABLE,
        pull_down_en=@gpio.GPIO_PULLDOWN_DISABLE,
        intr_type=@gpio.GPIO_INTR_DISABLE,
      )
      let _ = @task.xTaskCreate(
        fn(_) {
          for {
            @task.vTaskDelay(@task.pdMS_TO_TICKS(1000))
            let _ = @gpio.gpio_set_level?(LED_GPIO_PIN, 1)
            @task.vTaskDelay(@task.pdMS_TO_TICKS(1000))
            let _ = @gpio.gpio_set_level?(LED_GPIO_PIN, 0)
    
          }
        },
        @ctypes.CString::from_bytes(b"LED Blink\x00"),
        2048,
        5,
      )
      for {
        for {
          println("Hello, Moonbit!")
          @task.vTaskDelay(@task.pdMS_TO_TICKS(1000))
        }
      }
    }
    
    ///|
    fn main {
      moonbit_main()
    }
    ```
    The above code creates two tasks: one for blinking the LED and another for printing `"Hello, Moonbit!"`.

- Configure the build target (using ESP32-C3 as an example):
   ```bash
   idf.py -C ./.moonbit_esp32 set-target esp32c3
   ```

- Build the project:
   ```bash
   make build
   ```
   This command will package your MoonBit project into a `.a` file and copy it to the template project folder `.moonbit_esp32`.

- Choose one of the following options to proceed:

  1. **Compile and flash to the device**:
     ```bash
     idf.py -C ./.moonbit_esp32 build
     idf.py -C ./.moonbit_esp32 flash monitor
     ```

  2. **Simulate using QEMU** (if installed):
     ```bash
     idf.py -C ./.moonbit_esp32 qemu monitor
     ```
     You can find the installation instructions for QEMU [here](https://docs.espressif.com/projects/esp-idf/en/v5.4.1/esp32c3/api-guides/tools/qemu.html).

