defmodule CrcTest do
  use ExUnit.Case
  doctest CRC

  def check_string() do
    "123456789"
  end

  test "crc8 test" do
    assert CRC.crc8(check_string()) == 0xF4
  end

  test "crc8_maxim test" do
    assert CRC.crc8_maxim(check_string()) == 0xA1
  end

  test "crc8_cdma2000 test" do
    assert CRC.crc8_cdma2000(check_string()) == 0xDA
  end
end
