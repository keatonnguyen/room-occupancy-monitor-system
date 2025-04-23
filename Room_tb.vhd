library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Room_tb is
end Room_tb;

architecture behavior of Room_tb is

    component Room
        port(
            clk          : in  std_logic;
            reset        : in  std_logic;
            entry        : in  std_logic;
            exit_signal         : in  std_logic;
            prog_max     : in  std_logic_vector(7 downto 0);
            occupancy    : out std_logic_vector(7 downto 0);
            max_capacity : out std_logic
        );
    end component;

    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal entry        : std_logic := '0';
    signal exit_signal         : std_logic := '0';
    signal prog_max     : std_logic_vector(7 downto 0) := "00000101";
    signal occupancy    : std_logic_vector(7 downto 0);
    signal max_capacity : std_logic;

    constant clk_period : time := 10 ns;

begin

    uut: Room port map (
        clk          => clk,
        reset        => reset,
        entry        => entry,
        exit_signal         => exit_signal,
        prog_max     => prog_max,
        occupancy    => occupancy,
        max_capacity => max_capacity
    );

    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    stim_proc: process
    begin
        -- Initial Reset
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        -- Try to exit_signal when room is empty (should do nothing)
        exit_signal <= '1';
        wait for clk_period;
        exit_signal <= '0';
        wait for clk_period * 2;

        -- Add 5 people
        for i in 1 to 5 loop
            entry <= '1';
            wait for clk_period;
            entry <= '0';
            wait for clk_period * 2;
        end loop;

        -- Try to add 1 more (should be blocked at max)
        entry <= '1';
        wait for clk_period;
        entry <= '0';
        wait for clk_period * 2;

        -- Remove 2 people
        for i in 1 to 2 loop
            exit_signal <= '1';
            wait for clk_period;
            exit_signal <= '0';
            wait for clk_period * 2;
        end loop;

        -- Add 1 person back (should succeed)
        entry <= '1';
        wait for clk_period;
        entry <= '0';
        wait for clk_period * 2;

        -- Reset system again
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        wait;
    end process;

end behavior;
