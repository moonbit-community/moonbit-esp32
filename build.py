# // Copyright 2025 International Digital Economy Academy
# //
# // Licensed under the Apache License, Version 2.0 (the "License");
# // you may not use this file except in compliance with the License.
# // You may obtain a copy of the License at
# //
# //     http://www.apache.org/licenses/LICENSE-2.0
# //
# // Unless required by applicable law or agreed to in writing, software
# // distributed under the License is distributed on an "AS IS" BASIS,
# // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# // See the License for the specific language governing permissions and
# // limitations under the License.

import platform
import sys
import pathlib
import json
import subprocess
import textwrap

COMPONENTS = ["gpio", "task", "lcd", "spi", "qemu_lcd"]

CURRENT_MODULE_NAME = "moonbitlang/esp32"


def make_include_list(esp_idf_path, app_root_dir, target):
    INCLUDE_LIST_TEMPLATE = [
        f"-I{app_root_dir}/.moonbit_esp32/build/config",
        f"-I{esp_idf_path}/components/newlib/platform_include",
        f"-I{esp_idf_path}/components/freertos/config/include",
        f"-I{esp_idf_path}/components/freertos/config/include/freertos",
        f"-I{esp_idf_path}/components/freertos/config/riscv/include",
        f"-I{esp_idf_path}/components/freertos/FreeRTOS-Kernel/include",
        f"-I{esp_idf_path}/components/freertos/FreeRTOS-Kernel/portable/riscv/include",
        f"-I{esp_idf_path}/components/freertos/FreeRTOS-Kernel/portable/riscv/include/freertos",
        f"-I{esp_idf_path}/components/freertos/esp_additions/include",
        f"-I{esp_idf_path}/components/esp_hw_support/include",
        f"-I{esp_idf_path}/components/esp_hw_support/include/soc",
        f"-I{esp_idf_path}/components/esp_hw_support/include/soc/{target}",
        f"-I{esp_idf_path}/components/esp_hw_support/dma/include",
        f"-I{esp_idf_path}/components/esp_hw_support/ldo/include",
        f"-I{esp_idf_path}/components/esp_hw_support/port/{target}/",
        f"-I{esp_idf_path}/components/esp_hw_support/port/{target}/include",
        f"-I{esp_idf_path}/components/esp_hw_support/port/{target}/private_include",
        f"-I{esp_idf_path}/components/heap/include",
        f"-I{esp_idf_path}/components/log/include",
        f"-I{esp_idf_path}/components/soc/include",
        f"-I{esp_idf_path}/components/soc/{target}",
        f"-I{esp_idf_path}/components/soc/{target}/include",
        f"-I{esp_idf_path}/components/hal/platform_port/include",
        f"-I{esp_idf_path}/components/hal/{target}/include",
        f"-I{esp_idf_path}/components/hal/include",
        f"-I{esp_idf_path}/components/esp_rom/include",
        f"-I{esp_idf_path}/components/esp_rom/include/{target}",
        f"-I{esp_idf_path}/components/esp_rom/{target}",
        f"-I{esp_idf_path}/components/esp_common/include",
        f"-I{esp_idf_path}/components/esp_system/include",
        f"-I{esp_idf_path}/components/esp_system/port/soc",
        f"-I{esp_idf_path}/components/esp_system/port/include/riscv",
        f"-I{esp_idf_path}/components/esp_system/port/include/private",
        f"-I{esp_idf_path}/components/riscv/include",
        f"-I{esp_idf_path}/components/lwip/include",
        f"-I{esp_idf_path}/components/lwip/include/apps",
        f"-I{esp_idf_path}/components/lwip/include/apps/sntp",
        f"-I{esp_idf_path}/components/lwip/lwip/src/include",
        f"-I{esp_idf_path}/components/lwip/port/include",
        f"-I{esp_idf_path}/components/lwip/port/freertos/include",
        f"-I{esp_idf_path}/components/lwip/port/esp32xx/include",
        f"-I{esp_idf_path}/components/lwip/port/esp32xx/include/arch",
        f"-I{esp_idf_path}/components/lwip/port/esp32xx/include/sys",
        f"-I{esp_idf_path}/components/esp_driver_gpio/include",
        f"-I{esp_idf_path}/components/esp_pm/include",
        f"-I{esp_idf_path}/components/mbedtls/port/include",
        f"-I{esp_idf_path}/components/mbedtls/mbedtls/include",
        f"-I{esp_idf_path}/components/mbedtls/mbedtls/library",
        f"-I{esp_idf_path}/components/mbedtls/esp_crt_bundle/include",
        f"-I{esp_idf_path}/components/mbedtls/mbedtls/3rdparty/everest/include",
        f"-I{esp_idf_path}/components/mbedtls/mbedtls/3rdparty/p256-m",
        f"-I{esp_idf_path}/components/mbedtls/mbedtls/3rdparty/p256-m/p256-m",
        f"-I{esp_idf_path}/components/esp_app_format/include",
        f"-I{esp_idf_path}/components/esp_bootloader_format/include",
        f"-I{esp_idf_path}/components/app_update/include",
        f"-I{esp_idf_path}/components/bootloader_support/include",
        f"-I{esp_idf_path}/components/bootloader_support/bootloader_flash/include",
        f"-I{esp_idf_path}/components/esp_partition/include",
        f"-I{esp_idf_path}/components/efuse/include",
        f"-I{esp_idf_path}/components/efuse/{target}/include",
        f"-I{esp_idf_path}/components/esp_mm/include",
        f"-I{esp_idf_path}/components/spi_flash/include",
        f"-I{esp_idf_path}/components/pthread/include",
        f"-I{esp_idf_path}/components/esp_timer/include",
        f"-I{esp_idf_path}/components/esp_driver_gptimer/include",
        f"-I{esp_idf_path}/components/esp_ringbuf/include",
        f"-I{esp_idf_path}/components/esp_driver_uart/include",
        f"-I{esp_idf_path}/components/vfs/include",
        f"-I{esp_idf_path}/components/app_trace/include",
        f"-I{esp_idf_path}/components/esp_event/include",
        f"-I{esp_idf_path}/components/nvs_flash/include",
        f"-I{esp_idf_path}/components/esp_driver_pcnt/include",
        f"-I{esp_idf_path}/components/esp_driver_spi/include",
        f"-I{esp_idf_path}/components/esp_driver_mcpwm/include",
        f"-I{esp_idf_path}/components/esp_driver_ana_cmpr/include",
        f"-I{esp_idf_path}/components/esp_driver_i2s/include",
        f"-I{esp_idf_path}/components/sdmmc/include",
        f"-I{esp_idf_path}/components/esp_driver_sdmmc/include",
        f"-I{esp_idf_path}/components/esp_driver_sdspi/include",
        f"-I{esp_idf_path}/components/esp_driver_sdio/include",
        f"-I{esp_idf_path}/components/esp_driver_dac/include",
        f"-I{esp_idf_path}/components/esp_driver_rmt/include",
        f"-I{esp_idf_path}/components/esp_driver_tsens/include",
        f"-I{esp_idf_path}/components/esp_driver_sdm/include",
        f"-I{esp_idf_path}/components/esp_driver_i2c/include",
        f"-I{esp_idf_path}/components/esp_driver_ledc/include",
        f"-I{esp_idf_path}/components/esp_driver_parlio/include",
        f"-I{esp_idf_path}/components/esp_driver_usb_serial_jtag/include",
        f"-I{esp_idf_path}/components/driver/deprecated",
        f"-I{esp_idf_path}/components/driver/i2c/include",
        f"-I{esp_idf_path}/components/driver/touch_sensor/include",
        f"-I{esp_idf_path}/components/driver/twai/include",
        f"-I{esp_idf_path}/components/esp_phy/include",
        f"-I{esp_idf_path}/components/esp_phy/{target}/include",
        f"-I{esp_idf_path}/components/esp_vfs_console/include",
        f"-I{esp_idf_path}/components/esp_netif/include",
        f"-I{esp_idf_path}/components/wpa_supplicant/include",
        f"-I{esp_idf_path}/components/wpa_supplicant/port/include",
        f"-I{esp_idf_path}/components/wpa_supplicant/esp_supplicant/include",
        f"-I{esp_idf_path}/components/esp_coex/include",
        f"-I{esp_idf_path}/components/esp_wifi/include",
        f"-I{esp_idf_path}/components/esp_wifi/wifi_apps/include",
        f"-I{esp_idf_path}/components/esp_wifi/wifi_apps/nan_app/include",
        f"-I{esp_idf_path}/components/esp_wifi/include/local",
        f"-I{esp_idf_path}/components/unity/include",
        f"-I{esp_idf_path}/components/unity/unity/src",
        f"-I{esp_idf_path}/components/cmock/CMock/src",
        f"-I{esp_idf_path}/components/console",
        f"-I{esp_idf_path}/components/http_parser",
        f"-I{esp_idf_path}/components/esp-tls",
        f"-I{esp_idf_path}/components/esp-tls/esp-tls-crypto",
        f"-I{esp_idf_path}/components/esp_adc/include",
        f"-I{esp_idf_path}/components/esp_adc/interface",
        f"-I{esp_idf_path}/components/esp_adc/{target}/include",
        f"-I{esp_idf_path}/components/esp_adc/deprecated/include",
        f"-I{esp_idf_path}/components/esp_driver_isp/include",
        f"-I{esp_idf_path}/components/esp_driver_cam/include",
        f"-I{esp_idf_path}/components/esp_driver_cam/interface",
        f"-I{esp_idf_path}/components/esp_driver_jpeg/include",
        f"-I{esp_idf_path}/components/esp_driver_ppa/include",
        f"-I{esp_idf_path}/components/esp_eth/include",
        f"-I{esp_idf_path}/components/esp_gdbstub/include",
        f"-I{esp_idf_path}/components/esp_hid/include",
        f"-I{esp_idf_path}/components/tcp_transport/include",
        f"-I{esp_idf_path}/components/esp_http_client/include",
        f"-I{esp_idf_path}/components/esp_http_server/include",
        f"-I{esp_idf_path}/components/esp_https_ota/include",
        f"-I{esp_idf_path}/components/esp_https_server/include",
        f"-I{esp_idf_path}/components/esp_psram/include",
        f"-I{esp_idf_path}/components/esp_lcd/include",
        f"-I{esp_idf_path}/components/esp_lcd/interface",
        f"-I{esp_idf_path}/components/protobuf-c/protobuf-c",
        f"-I{esp_idf_path}/components/protocomm/include/common",
        f"-I{esp_idf_path}/components/protocomm/include/security",
        f"-I{esp_idf_path}/components/protocomm/include/transports",
        f"-I{esp_idf_path}/components/protocomm/include/crypto/srp6a",
        f"-I{esp_idf_path}/components/protocomm/proto-c",
        f"-I{esp_idf_path}/components/esp_local_ctrl/include",
        f"-I{esp_idf_path}/components/espcoredump/include",
        f"-I{esp_idf_path}/components/espcoredump/include/port/riscv",
        f"-I{esp_idf_path}/components/wear_levelling/include",
        f"-I{esp_idf_path}/components/fatfs/diskio",
        f"-I{esp_idf_path}/components/fatfs/src",
        f"-I{esp_idf_path}/components/fatfs/vfs",
        f"-I{esp_idf_path}/components/idf_test/include",
        f"-I{esp_idf_path}/components/idf_test/include/{target}",
        f"-I{esp_idf_path}/components/ieee802154/include",
        f"-I{esp_idf_path}/components/json/cJSON",
        f"-I{esp_idf_path}/components/mqtt/esp-mqtt/include",
        f"-I{esp_idf_path}/components/nvs_sec_provider/include",
        f"-I{esp_idf_path}/components/spiffs/include",
        f"-I{esp_idf_path}/components/wifi_provisioning/include",
        f"-I{esp_idf_path}/components/soc/{target}/register",
    ]
    return INCLUDE_LIST_TEMPLATE


USER_MAIN_CC_FLAGS = [
    "-c",
    "-DESP_PLATFORM",
    '-DIDF_VER=\\"v5.4.1\\"',
    '-DMBEDTLS_CONFIG_FILE=\\"mbedtls/esp_config.h\\"',
    "-DSOC_MMU_PAGE_SIZE=CONFIG_MMU_PAGE_SIZE",
    "-DSOC_XTAL_FREQ_MHZ=CONFIG_XTAL_FREQ",
    "-DUNITY_INCLUDE_CONFIG_H",
    "-D_GLIBCXX_HAVE_POSIX_SEMAPHORE",
    "-D_GLIBCXX_USE_POSIX_SEMAPHORE",
    "-D_GNU_SOURCE",
    "-D_POSIX_READER_WRITER_LOCKS",
    "-march=rv32imc_zicsr_zifencei",
    "-fdiagnostics-color=always",
    "-ffunction-sections",
    "-fdata-sections",
    "-Wall",
    "-Werror=all",
    "-Wno-error=unused-function",
    "-Wno-error=unused-variable",
    "-Wno-error=unused-but-set-variable",
    "-Wno-error=deprecated-declarations",
    "-Wextra",
    "-Wno-unused-parameter",
    "-Wno-sign-compare",
    "-Wno-enum-conversion",
    "-gdwarf-4",
    "-ggdb",
    "-nostartfiles",
    "-Og",
    "-fno-shrink-wrap",
    "-fstrict-volatile-bitfields",
    "-fno-jump-tables",
    "-fno-tree-switch-conversion",
    "-std=gnu17",
    "-Wno-old-style-declaration",
    "-Wno-missing-braces",
    "-Wno-incompatible-pointer-types",
]

MOONBIT_APP_H_TEMPLATE = """// generated by postadd script
#include <stdint.h>

void moonbit_runtime_init(int argc, char **argv);
void moonbit_init();
int32_t {USER_MODULE_NAME_ESCAPED}$main$moonbit_main(int argc, char **argv);
"""

MAIN_C_TEMPLATE = """// generated by postadd script
#include <stddef.h>
#include "moonbit_app.h"

void app_main()
{{
    moonbit_runtime_init(0, NULL);
    moonbit_init();
    {USER_MODULE_NAME_ESCAPED}$main$moonbit_main(0, NULL);
}}
"""

MAKEFILE_TEMPLATE = """# generated by postadd script

MOONBIT_DIR := ./.moonbit_esp32
IDF := idf.py -C $(MOONBIT_DIR)

build:
\tMOON_CC={ESP_IDF_GCC_PATH} moon build --target native
\trm -f ./.moonbit_esp32/components/moonbit_app/libmoonbit_app.a
\t{ESP_IDF_AR_PATH} \\
\t    rcs \
\t    ./.moonbit_esp32/components/moonbit_app/libmoonbit_app.a \\
\t    ./target/native/release/build/.mooncakes/{CURRENT_MODULE_NAME}/components/gpio/moonbit_esp32_gpio_stub.o \\
\t    ./target/native/release/build/.mooncakes/{CURRENT_MODULE_NAME}/components/task/moonbit_esp32_task_stub.o \\
\t    ./target/native/release/build/.mooncakes/{CURRENT_MODULE_NAME}/components/lcd/moonbit_esp32_lcd_stub.o \\
\t    ./target/native/release/build/.mooncakes/{CURRENT_MODULE_NAME}/components/spi/moonbit_esp32_spi_stub.o \\
\t    ./target/native/release/build/runtime.o \\
\t    ./target/native/release/build/main/main.exe
\t{ESP_IDF_AR_PATH} \\
\t    -t ./.moonbit_esp32/components/moonbit_app/libmoonbit_app.a
\t$(IDF) build

.PHONY: set-target flash monitor qemu

set-target:
\t$(IDF) set-target $(word 2,$(MAKECMDGOALS))

flash:
\t$(IDF) flash $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

qemu:
\t$(IDF) qemu --graphics monitor

monitor:
\t@:

"""


def create_moonbit_esp32_template_project(app_root_dir: pathlib.Path):
    """
    .moonbit_esp32
    ├── CMakeLists.txt
    ├── build
    ├── components
    │   └── moonbit_app
    │       ├── CMakeLists.txt
    │       ├── include
    │       │   └── moonbit_app.h
    │       └── libmoonbit_app.a
    ├── main
    │   ├── CMakeLists.txt
    │   └── main.c
    ├── sdkconfig
    """

    moonbit_esp32_dir = app_root_dir / ".moonbit_esp32"

    if moonbit_esp32_dir.exists():
        print(f"{moonbit_esp32_dir} already exists")
        return

    if not moonbit_esp32_dir.exists():
        moonbit_esp32_dir.mkdir(parents=True)

    components_dir = moonbit_esp32_dir / "components"
    if not components_dir.exists():
        components_dir.mkdir(parents=True)

    moonbit_app_dir = components_dir / "moonbit_app"
    if not moonbit_app_dir.exists():
        moonbit_app_dir.mkdir(parents=True)

    include_dir = moonbit_app_dir / "include"
    if not include_dir.exists():
        include_dir.mkdir(parents=True)

    main_dir = moonbit_esp32_dir / "main"
    if not main_dir.exists():
        main_dir.mkdir(parents=True)

    with open(app_root_dir / "moon.mod.json") as fp:
        j = json.load(fp)
        user_module_name = j["name"]

    with open(app_root_dir / ".moonbit_esp32/CMakeLists.txt", "w") as fp:
        fp.write(
            textwrap.dedent("""\
        cmake_minimum_required(VERSION 3.16)

        set(SDKCONFIG "${CMAKE_SOURCE_DIR}/../sdkconfig")

        include($ENV{IDF_PATH}/tools/cmake/project.cmake)
        project(moonbit_esp32_project)
        """)
        )
    with open(app_root_dir / ".moonbit_esp32/.gitignore", "w") as fp:
        fp.write(
            textwrap.dedent("""\
            /build
            /components/moonbit_app/libmoonbit_app.a
            """)
        )

    with open(
        app_root_dir / ".moonbit_esp32/main/main.c",
        "w",
    ) as fp:
        fp.write(
            MAIN_C_TEMPLATE.format(
                USER_MODULE_NAME_ESCAPED="$" + user_module_name.replace("/", "$")
            )
        )
    with open(app_root_dir / ".moonbit_esp32/main/CMakeLists.txt", "w") as fp:
        fp.write(
            textwrap.dedent("""\
        idf_component_register(SRCS
            "main.c"
            INCLUDE_DIRS "."
            REQUIRES moonbit_app
        )

        target_compile_options(${COMPONENT_LIB} PRIVATE -Wno-missing-braces)
        """)
        )

    with open(
        app_root_dir / ".moonbit_esp32/components/moonbit_app/CMakeLists.txt",
        "w",
    ) as fp:
        fp.write(
            textwrap.dedent("""\
        idf_component_register(
            INCLUDE_DIRS "include"
        )
        add_prebuilt_library(moonbit_app "libmoonbit_app.a"
        )

        target_link_libraries(${COMPONENT_LIB} INTERFACE moonbit_app)
        """)
        )

    with open(
        app_root_dir / ".moonbit_esp32/components/moonbit_app/include/moonbit_app.h",
        "w",
    ) as fp:
        fp.write(
            MOONBIT_APP_H_TEMPLATE.format(
                USER_MODULE_NAME_ESCAPED="$" + user_module_name.replace("/", "$")
            )
        )


def find_esp_idf():
    home_path = pathlib.Path.home()
    esp = home_path.joinpath(".espressif")
    if not esp.exists():
        print("cannot find esp-idf in your system")
        exit(1)

    with open(esp.joinpath("esp_idf.json"), "r") as f:
        j = json.load(f)

    if "idfInstalled" not in j:
        print("cannot find esp-idf in your system")
        exit(1)

    found = False
    version_info = None
    for item in j["idfInstalled"]:
        if "version" in j["idfInstalled"][item]:
            v = j["idfInstalled"][item]["version"]
            if v == "5.4.1":
                print(f"found esp-idf {v} in {j['idfInstalled'][item]['path']}")
                found = True
                version_info = j["idfInstalled"][item]
                break
    if not found:
        print("only support esp-idf 5.4.1, but cannot find it")
        exit(1)

    esp_idf_path = version_info["path"]

    export_sh_path = esp_idf_path + "/export.sh"

    command = f'bash -c "source {export_sh_path} >/dev/null 2>&1 && which riscv32-esp-elf-gcc"'

    result = subprocess.run(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=True,
        executable="/bin/bash",
    )
    riscv32_esp_elf_gcc_path = result.stdout.decode().strip()

    app_root_dir = pathlib.Path(__file__).parent.parent.parent.parent.absolute()

    cc_flags = " ".join(make_include_list(esp_idf_path, app_root_dir, "esp32c3"))

    module_root_dir = pathlib.Path(__file__).parent
    for component in COMPONENTS:
        component_dir = module_root_dir / "src" / "components" / component
        with open(component_dir / "moon.pkg.json", "r") as fp:
            pkg_json = json.load(fp)
            if not pkg_json["link"]["native"]["cc"]:
                pkg_json["link"]["native"]["cc"] = riscv32_esp_elf_gcc_path
            if not pkg_json["link"]["native"]["stub-cc"]:
                pkg_json["link"]["native"]["stub-cc"] = riscv32_esp_elf_gcc_path
            if not pkg_json["link"]["native"]["cc-flags"]:
                pkg_json["link"]["native"]["stub-cc-flags"] = cc_flags

        with open(component_dir / "moon.pkg.json", "w") as fp:
            json.dump(pkg_json, fp, indent=2)
    if not (app_root_dir / "Makefile").exists():
        with open(app_root_dir / "Makefile", "w") as fp:
            fp.write(
                MAKEFILE_TEMPLATE.format(
                    ESP_IDF_GCC_PATH=riscv32_esp_elf_gcc_path,
                    ESP_IDF_AR_PATH=riscv32_esp_elf_gcc_path.replace(
                        "riscv32-esp-elf-gcc", "riscv32-esp-elf-ar"
                    ),
                    CURRENT_MODULE_NAME=CURRENT_MODULE_NAME,
                )
            )

    with open(app_root_dir / "src/main/moon.pkg.json", "r") as fp:
        j = json.load(fp)

    with open(app_root_dir / "src/main/moon.pkg.json", "w") as fp:
        j.setdefault("link", {}).setdefault("native", {})
        if not j["link"]["native"].get("cc"):
            j["link"]["native"]["cc"] = riscv32_esp_elf_gcc_path
        if not j["link"]["native"].get("stub-cc"):
            j["link"]["native"]["stub-cc"] = riscv32_esp_elf_gcc_path
        if not j["link"]["native"].get("cc-flags"):
            j["link"]["native"]["cc-flags"] = " ".join(USER_MAIN_CC_FLAGS)
        json.dump(j, fp, indent=2)

    create_moonbit_esp32_template_project(app_root_dir)


def main():
    if platform.system() != "Darwin":
        print("only support macOS")
        sys.exit(1)
    find_esp_idf()


if __name__ == "__main__":
    main()
