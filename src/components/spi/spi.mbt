///|
pub(all) enum SPI_HOST_DEVICE {
  SPI1_HOST = 0
  SPI2_HOST = 1
}

///|
pub fn SPI_HOST_DEVICE::to_int(self : SPI_HOST_DEVICE) -> Int = "%identity"

///|
pub(all) enum SPI_COMMON_DMA {
  SPI_DMA_DISABLED = 0
  SPI_DMA_CH_AUTO = 3
}

///|
pub fn SPI_COMMON_DMA::to_int(self : SPI_COMMON_DMA) -> Int = "%identity"

///|
pub(all) struct SPI_BUS_CONFIG {
  sclk_io_num : Int
  mosi_io_num : Int
  miso_io_num : Int
  quadwp_io_num : Int
  quadhd_io_num : Int
  max_transfer_sz : Int
  flags : UInt
}

///|
extern "C" fn __spi_bus_initialize(
  host_id : Int,
  sclk_io_num : Int,
  mosi_io_num : Int,
  miso_io_num : Int,
  quadwp_io_num : Int,
  quadhd_io_num : Int,
  max_transfer_sz : Int,
  flags : UInt,
  dma_chan : Int
) -> Int = "__wrap_spi_bus_initialize"

///|
pub fn spi_bus_initialize(
  host_id : SPI_HOST_DEVICE,
  bus_config : SPI_BUS_CONFIG,
  dma_chan : SPI_COMMON_DMA
) -> Int {
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
