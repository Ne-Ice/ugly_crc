defmodule CrcTest do
  use ExUnit.Case
  doctest CRC

  test "Reverce test" do
    assert CRC.reverce_byte(0x80) == 0x01
  end

  test "crc8 check" do
    assert CRC.crc8("123456789") == 0xF4
  end

  test "crc8_maxim check" do
    assert CRC.crc8_maxim("123456789") == 0xA1
  end
end
