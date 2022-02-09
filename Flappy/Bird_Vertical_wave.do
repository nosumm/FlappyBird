onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Bird_Vertical_testbench/reset
add wave -noupdate /Bird_Vertical_testbench/bird_pos
add wave -noupdate /Bird_Vertical_testbench/clock
add wave -noupdate /Bird_Vertical_testbench/out
add wave -noupdate /Bird_Vertical_testbench/mode
add wave -noupdate /Bird_Vertical_testbench/fly
add wave -noupdate /Bird_Vertical_testbench/gravity
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {130 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
WaveRestoreZoom {0 ps} {3440 ps}
