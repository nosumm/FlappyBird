onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Generate_Pipe_testbench/clock
add wave -noupdate /Generate_Pipe_testbench/light
add wave -noupdate /Generate_Pipe_testbench/reset
add wave -noupdate /Generate_Pipe_testbench/enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 293
configure wave -valuecolwidth 220
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {883 ps}
