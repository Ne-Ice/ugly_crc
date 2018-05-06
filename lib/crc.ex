defmodule CRC do
  use Bitwise

  def crc8(data) do
    crc8_calculation(data, 0x07, 0x00, false, false, 0x00)
  end

  def crc8_maxim(data) do
    crc8_calculation(data, 0x31, 0x00, true, true, 0x00)
  end

  def crc8_cdma2000(data) do
    crc8_calculation(data, 0x9B, 0xFF, false, false, 0x00)
  end

  defp crc8_calculation(<<first_byte :: size(8), other_bytes :: binary>>, polynomial, initial, ref_in, ref_out, xor_out) do
    crc_byte = initial ^^^ if ref_in do reverce_byte(first_byte) else first_byte end
    crc_byte = crc8_loop(crc_byte, polynomial, ref_out)
    crc8_calculation(other_bytes, polynomial, crc_byte, ref_in, ref_out, xor_out)
  end

  defp crc8_calculation(<<>>, _, crc_byte, _, ref_out, xor_out) do
    bxor(if ref_out do reverce_byte(crc_byte) else crc_byte end, xor_out)
  end

  defp crc8_loop(crc_byte, poly, ref_out, counter \\ 0)
  defp crc8_loop(crc_byte, poly, ref_out, counter) when counter < 8 do
    if ((crc_byte &&& 0x80) != 0) do
      rem((crc_byte <<< 1), 256) |> bxor(poly)
    else
      rem((crc_byte <<< 1), 256)
    end
    |> crc8_loop(poly, ref_out, counter + 1)
  end

  defp crc8_loop(crc_byte, _, _, 8) do crc_byte end

  defp reverce_byte(byte) do rem((byte * 0x202020202) &&& 0x10884422010, 1023) end
end
