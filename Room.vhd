library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Room is
    port(
        clk          : in  std_logic;
        reset        : in  std_logic;
        entry        : in  std_logic;
        exit_signal  : in  std_logic;
        prog_max     : in  std_logic_vector(7 downto 0);
        occupancy    : out std_logic_vector(7 downto 0);
        max_capacity : out std_logic
    );
end Room;

architecture Behavioral of Room is
    type state_type is (IDLE, NORMAL, FULL);
    signal current_state, next_state : state_type := IDLE;

    signal count         : unsigned(7 downto 0) := (others => '0');
    signal max_occupancy : unsigned(7 downto 0);
begin

    max_occupancy <= unsigned(prog_max);

    process(clk, reset)
    begin
        if reset = '1' then
            count         <= (others => '0');
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;

            case current_state is
                when IDLE =>
                    count <= (others => '0');
                    if entry = '1' and (count < max_occupancy) then
                        count <= count + 1;
                    end if;

                when NORMAL =>
                    if entry = '1' and count < max_occupancy then
                        count <= count + 1;
                    elsif exit_signal = '1' and count > 0 then
                        count <= count - 1;
                    end if;

                when FULL =>
                    if exit_signal = '1' and count > 0 then
                        count <= count - 1;
                    end if;

                when others =>
                    null;
            end case;
        end if;
    end process;

    process(current_state, entry, exit_signal, count, max_occupancy)
    begin
        next_state <= current_state;
        case current_state is
            when IDLE =>
                if entry = '1' then
                    next_state <= NORMAL;
                end if;

            when NORMAL =>
                if count = max_occupancy then
                    next_state <= FULL;
                end if;

            when FULL =>
                if count < max_occupancy then
                    next_state <= NORMAL;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    occupancy <= std_logic_vector(count);

    -- max_capacity process that reacts immediately
    process(count, max_occupancy)
    begin
        if count = max_occupancy then
            max_capacity <= '1';
        else
            max_capacity <= '0';
        end if;
    end process;

end Behavioral;
