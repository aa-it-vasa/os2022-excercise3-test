echo "Uppgift 2, test 1"
echo

fail=false
numtests=5
currtest=1

./ovn2
if [ $? -eq 139 ]; then
    echo "[1/5] Fel: Programmet kraschade utan indata!"
    fail=true
else
  echo "[1/5] Ok: Programmet kraschade inte utan indata"
fi

currtest=$((currtest+1))

./ovn2
if [ $? -eq 1 ]; then
  echo "[2/5] Ok: Programmet gav output 1 utan indata!" 
else
  echo "[2/5] Fel: Programmet gav inte output 1 utan indata!"
    fail=true
fi

currtest=$((currtest+1))

./ovn2 0
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Programmet gav output 0." 
else
  echo "[$currtest/$numtests] Fel: Programmet gav inte output 0!"
    fail=true
fi

currtest=$((currtest+1))

input=($(shuf -i 0-149 -n 4))
output=$(./ovn2 "${input[@]}")
avg=$(echo "${input[@]}"|jq -s add/length)

max=${input[0]}
min=${input[0]}
sum=0
count=0
for i in "${input[@]}"; do
  sum=$(($sum+$i))
  (( i > max )) && max=$i
  (( i < min )) && min=$i
  count=$(($count+1))
done

avg=$(bc -l <<< $sum/$count)
code=$?
expected_output=$(printf "The average value is %f\nThe minimum value is %d\nThe maximum value is %d" $avg  $min $max) 

if [ "$output" == "$expected_output" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad för input \"${input[@]}\". Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi


currtest=$((currtest+1))

input=($(shuf -i 0-149 -n 50))
output=$(./ovn2 "${input[@]}")
avg=$(echo "${input[@]}"|jq -s add/length)

max=${input[0]}
min=${input[0]}
sum=0
count=0
for i in "${input[@]}"; do
  sum=$(($sum+$i))
  (( i > max )) && max=$i
  (( i < min )) && min=$i
  count=$(($count+1))
done

avg=$(bc -l <<< $sum/$count)
code=$?
expected_output=$(printf "The average value is %f\nThe minimum value is %d\nThe maximum value is %d" $avg  $min $max) 

if [ "$output" == "$expected_output" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad för input \"${input[@]}\". Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

echo

if [ "$fail" = true ]; then
  echo "Misslyckades med något av testen!"
  exit 1
else
  echo "Klarade alla test!"
  exit 0
fi