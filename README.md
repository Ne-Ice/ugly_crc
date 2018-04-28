# CRC

CRC8 module for Elixir

## Installation

The package can be installed
by adding `crc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:crc, git: "https://github.com/Ne-Ice/ugly_crc", tag: "0.1.0" }
  ]
end
```
## Usage
```elixir
CRC.crc8(<<binary_data>>)
CRC.crc8_maxim(<<binary_data>>)
CRC.crc8_cdma2000(<<binary_data>>)
```
