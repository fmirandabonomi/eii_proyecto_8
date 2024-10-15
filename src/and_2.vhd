library IEEE;
use IEEE.std_logic_1164.all;

entity and_2 is
  port (
    A : in  std_logic;
    B : in  std_logic;
    Y : out std_logic
  );
end and_2;

architecture arch of and_2 is
begin
  Y <= A and B;
end arch;
