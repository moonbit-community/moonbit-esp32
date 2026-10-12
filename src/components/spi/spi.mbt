// // Copyright 2025 International Digital Economy Academy
// //
// // Licensed under the Apache License, Version 2.0 (the "License");
// // you may not use this file except in compliance with the License.
// // You may obtain a copy of the License at
// //
// //     http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing, software
// // distributed under the License is distributed on an "AS IS" BASIS,
// // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// // See the License for the specific language governing permissions and
// // limitations under the License.

///|
pub(all) enum SPI_HOST_DEVICE {
  SPI1_HOST = 0
  SPI2_HOST = 1
}

///|
pub fn SPI_HOST_DEVICE::to_int(self : SPI_HOST_DEVICE) -> Int32 = "%identity"

///|
pub(all) enum SPI_COMMON_DMA {
  SPI_DMA_DISABLED = 0
  SPI_DMA_CH_AUTO = 3
}

///|
pub fn SPI_COMMON_DMA::to_int(self : SPI_COMMON_DMA) -> Int32 = "%identity"

///|
pub(all) struct SPI_BUS_CONFIG {
  sclk_io_num : Int32
  mosi_io_num : Int32
  miso_io_num : Int32
  quadwp_io_num : Int32
  quadhd_io_num : Int32
  max_transfer_sz : Int32
  flags : UInt32
}

///|
extern "C" fn __spi_bus_initialize(
  host_id : Int32,
  sclk_io_num : Int32,
  mosi_io_num : Int32,
  miso_io_num : Int32,
  quadwp_io_num : Int32,
  quadhd_io_num : Int32,
  max_transfer_sz : Int32,
  flags : UInt32,
  dma_chan : Int32,
) -> Int32 = "__wrap_spi_bus_initialize"

///|
pub fn spi_bus_initialize(
  host_id : SPI_HOST_DEVICE,
  bus_config : SPI_BUS_CONFIG,
  dma_chan : SPI_COMMON_DMA,
) -> Int32 {
  __spi_bus_initialize(
    host_id.to_int(),
    bus_config.sclk_io_num,
    bus_config.mosi_io_num,
    bus_config.miso_io_num,
    bus_config.quadwp_io_num,
    bus_config.quadhd_io_num,
    bus_config.max_transfer_sz,
    bus_config.flags,
    dma_chan.to_int(),
  )
}
