onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /game_status_testbench/reset
add wave -noupdate /game_status_testbench/bird_pos
add wave -noupdate /game_status_testbench/OFB
add wave -noupdate /game_status_testbench/pipe1
add wave -noupdate /game_status_testbench/height1
add wave -noupdate /game_status_testbench/size1
add wave -noupdate /game_status_testbench/game_over
add wave -noupdate /game_status_testbench/increment
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 316
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {926 ps}
