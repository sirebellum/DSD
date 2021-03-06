# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/lubuntu/Dev/DSD/Lab_1/Lab_1.cache/wt [current_project]
set_property parent.project_path /home/lubuntu/Dev/DSD/Lab_1/Lab_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo /home/lubuntu/Dev/DSD/Lab_1/Lab_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib /media/sf_gits/DSD/Lab_1/Lab_1.srcs/sources_1/imports/Downloads/tutorial.v
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/lubuntu/Dev/DSD/Lab_1/Lab_1.srcs/constrs_1/imports/Downloads/Tutorial_C.xdc
set_property used_in_implementation false [get_files /home/lubuntu/Dev/DSD/Lab_1/Lab_1.srcs/constrs_1/imports/Downloads/Tutorial_C.xdc]


synth_design -top tutorial -part xc7a100tcsg324-1


write_checkpoint -force -noxdef tutorial.dcp

catch { report_utilization -file tutorial_utilization_synth.rpt -pb tutorial_utilization_synth.pb }
