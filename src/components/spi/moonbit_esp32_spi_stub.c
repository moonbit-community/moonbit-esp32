/*
 * // Copyright 2025 International Digital Economy Academy
 * //
 * // Licensed under the Apache License, Version 2.0 (the "License");
 * // you may not use this file except in compliance with the License.
 * // You may obtain a copy of the License at
 * //
 * //     http://www.apache.org/licenses/LICENSE-2.0
 * //
 * // Unless required by applicable law or agreed to in writing, software
 * // distributed under the License is distributed on an "AS IS" BASIS,
 * // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * // See the License for the specific language governing permissions and
 * // limitations under the License.
 */

#include "driver/spi_master.h"

esp_err_t __wrap_spi_bus_initialize(int32_t host_device,

                                    int32_t sclk_io_num, int32_t mosi_io_num,
                                    int32_t miso_io_num, int32_t quadwp_io_num,
                                    int32_t quadhd_io_num,
                                    int32_t max_transfer_sz, uint32_t flags,
                                    int32_t dma_chan) {
  spi_bus_config_t buscfg = {
      .sclk_io_num = sclk_io_num,
      .mosi_io_num = mosi_io_num,
      .miso_io_num = miso_io_num,
      .quadwp_io_num = quadwp_io_num,
      .quadhd_io_num = quadhd_io_num,
      .max_transfer_sz = max_transfer_sz,
      .flags = flags,
  };

  esp_err_t ret = spi_bus_initialize(host_device, &buscfg, dma_chan);
  return ret;
}
