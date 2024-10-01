local TableZ = {}

 function TableZ.Change (Table)
    if Table == nil then
        return "null"
    end
local Str = ""

for index, value in ipairs(Table) do
    
Str = Str .. "/n" .. tostring(value)

end

task.wait()
print(string.gsub(Str, "/n", " "), "READ M")
return string.gsub(Str, "/n", " ")

end

return TableZ