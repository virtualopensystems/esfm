----------------------------------------------------------------------------------
-- Company: VirtualOpenSystems
-- Engineer: Stefano Cirici
-- 
-- Create Date: 10/04/2022 02:12:57 PM
-- Design Name: Function-level reset assert
-- Module Name: flr_assert - Behavioral
-- Project Name: Function-level reset assert
-- Target Devices: any
-- Tool Versions: 
-- Description: This module assert any function-level request received
-- 
-- Dependencies: noone
-- 
-- Revision:
-- Revision 1.0 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity flr_assert is
port (  s_axi_aclk:         in std_logic;
        s_axi_aresetn:      in std_logic;
        usr_flr_fnc:        in std_logic_vector(7 downto 0);
        usr_flr_set:        in std_logic;
        usr_flr_clr:        in std_logic;
        usr_flr_done_fnc:   out std_logic_vector(7 downto 0);
        usr_flr_done_vld:   out std_logic
);
end flr_assert;

architecture beh of flr_assert is
    signal usr_flr_done_vld_s:      std_logic;
    signal usr_flr_done_vld_s_l:    std_logic; --latched
    signal usr_flr_done_fnc_s:      std_logic_vector(7 downto 0);
   
begin

    process(s_axi_aclk)
    begin
        if (s_axi_aclk = '1' and s_axi_aclk'event) then
            if (s_axi_aresetn = '0') then
                usr_flr_done_fnc_s <= (others=>'0');
                usr_flr_done_vld_s <= '0';
                usr_flr_done_vld_s_l <= '0';
	        else
                usr_flr_done_fnc_s <= usr_flr_done_fnc_s;
                usr_flr_done_vld_s <= usr_flr_done_vld_s;
                usr_flr_done_vld_s_l <= usr_flr_done_vld_s;  --latch valid signal
               
                if (usr_flr_set = '1' and usr_flr_clr = '0') then
                    -- assert reset done
                    usr_flr_done_fnc_s <= usr_flr_fnc;
                    usr_flr_done_vld_s <= '1';
                elsif (usr_flr_done_vld_s = '1') then
                    -- clear after one cycle
                    usr_flr_done_fnc_s <= (others=>'0');
                    usr_flr_done_vld_s <= '0';
                end if;
	       end if;
	   end if;
    end process;
    
    usr_flr_done_vld <= usr_flr_done_vld_s and not usr_flr_done_vld_s_l; -- assert for one cycle only
    usr_flr_done_fnc <= usr_flr_done_fnc_s;

end beh;
