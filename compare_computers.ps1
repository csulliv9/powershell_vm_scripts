$server_list = "GG043Q32E", "GG043Q32E", "GG043Q32E", "GG043Q32E"
$j=1
$max_cpu=-1
$max_mem=-1
$min_cpu = 101
$min_mem = 1073741824*5
#sub out for server name when we are using different servers
$max_cpu_name = $j
$max_mem_name = $j
$min_cpu_name = $j
$min_mem_name = $j
#compare servers
foreach ($i in $server_list){
    #invoke-command -scriptblock {import-csv $("C:\Users\212416516\Documents\powershell\vms\vm_usage_"+$j+".txt") | measure-object cpuusage -ave -max | select-object -expand average}
    #invoke-command -scriptblock {import-csv $("C:\Users\212416516\Documents\powershell\vms\vm_usage_"+$j+".txt") | measure-object memoryassigned  -max | select-object -expand maximum}
    $temp_cpu = invoke-command -scriptblock {import-csv $("C:\Users\212416516\Documents\powershell\vms\vm_usage_"+$j+".txt") | measure-object cpuusage -ave -max | select-object -expand average}
    $temp_mem = invoke-command -scriptblock {import-csv $("C:\Users\212416516\Documents\powershell\vms\vm_usage_"+$j+".txt") | measure-object memoryassigned  -max | select-object -expand maximum}
#max values
    if ($temp_cpu -gt $max_cpu){
        $max_cpu_name = $j
        $max_cpu = $temp_cpu
    }
    if ($temp_mem -gt $max_mem){
        $max_mem_name = $j
        $max_mem = $temp_mem
    }
#min_values
    if ($temp_cpu -lt $min_cpu){
        $min_cpu_name = $j
        $min_cpu = $temp_cpu
    }
    if ($temp_mem -lt $min_mem){
        $min_mem_name = $j
        $min_mem = $temp_mem
    }
    $j++
}

write-host "Highest CPU Utilization"
write-host $max_cpu_name

write-host "Highest Allocated Memory"
write-host $max_mem_name

write-host "Lowest CPU Utilization"
write-host $min_cpu_name 

write-host "Lowest Allocated Memory"
write-host $min_mem_name