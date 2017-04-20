

$vm_list = @(get-childitem "C:\Users\212416516\Documents\powershell\vms" | select -expandproperty fullname) 
$max_ave_cpu = -1
$cpu_table = foreach ($i in $vm_list) {
    $vm_name = import-csv $i | select-object name -unique
    $cpu = import-csv $i | select-object name, cpuusage
    $temp_cpu = import-csv $i | measure-object cpuusage -ave | select-object -expand average 
    if ($temp_cpu -gt $max_ave_cpu){
        $max_ave_cpu = $temp_cpu
        $max_cpu_vm_name = $vm_name
    }
}
write-host "Highest utilization"
write-host $max_cpu_vm_name.name 
import-csv $("C:\Users\212416516\Documents\powershell\vms\"+$max_cpu_vm_name.name+".txt") | measure-object cpuusage -ave -max
#write-host $max_ave_cpu"%"
$cpu = foreach ($i in $vm_list) {import-csv $i | measure-object cpuusage -ave -max | select-object  name, average}
$memory = foreach ($i in $vm_list) {import-csv $i | measure-object memoryassigned -max | select-object -expand  maximum}
$cpu_table

#measure-object memoryassigned -max}
