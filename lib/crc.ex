defmodule CRC do
  use Bitwise

  def crc8(data) do
    crc8_calculation(data, 0x07, 0x00, false, false, 0x00)
  end

  def crc8_maxim(data) do
    crc8_calculation(data, 0x31, 0x00, true, true, 0x00)
  end

  def crc8_calculation(<<first_byte :: size(8), other_bytes :: binary>>, polynomial, initial, ref_in, ref_out, xor_out) when ref_in == true do
    crc_byte = initial ^^^ reverce_byte(first_byte)
    crc_byte = crc8_loop(crc_byte, polynomial, ref_out)
    crc8_calculation(other_bytes, polynomial, crc_byte, ref_in, ref_out, xor_out)
  end

  def crc8_calculation(<<first_byte :: size(8), other_bytes :: binary>>, polynomial, initial, ref_in, ref_out, xor_out) when ref_in == false do
    crc_byte = initial ^^^ first_byte
    crc_byte = crc8_loop(crc_byte, polynomial, ref_out)
    crc8_calculation(other_bytes, polynomial, crc_byte, ref_in, ref_out, xor_out)
  end

  def crc8_calculation(<<>>, _, crc_byte, _, false, xor_out) do
    bxor(crc_byte, xor_out)
  end

  def crc8_calculation(<<>>, _, crc_byte, _, true, xor_out) do
    reverce_byte(crc_byte)
    |> bxor(xor_out)
  end

  defp crc8_loop(crc_byte, poly, ref_out, counter \\ 0)
  defp crc8_loop(crc_byte, poly, ref_out, counter) when counter < 8 do
    crc_byte = if ((crc_byte &&& 0x80) != 0) do
      crc_byte = :math.fmod((crc_byte <<< 1), 256)
      crc_byte = round(crc_byte)
      if ref_out do
        bxor(crc_byte,poly)
      else
        bxor(crc_byte,poly)
      end
    else
      crc_byte = :math.fmod((crc_byte <<< 1), 256)
      round(crc_byte)
    end
    crc8_loop(crc_byte, poly, ref_out, counter + 1)
  end

  defp crc8_loop(crc_byte, _, _, 8) do
    crc_byte
  end

  def reverce_byte(byte) do
    :math.fmod((byte * 0x202020202) &&& 0x10884422010, 1023)
    |> round
  end
end
