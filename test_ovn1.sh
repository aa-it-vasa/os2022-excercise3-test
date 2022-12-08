echo "Uppgift 1, test 1"
echo

fail=false
numtests=2
currtest=1

./ovn1
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Programmet gav output 0." 
else
  echo "[$currtest/$numtests] Fel: Programmet gav inte output 0!"
    fail=true
fi


currtest=$((currtest+1))

output=$(./ovn1 | tail -n1)
code=$?
product=$(($1*$2))
expected_output=$(printf "count = $product, should be $product, 100.000000%%") 

if [ "$output" == "$expected_output" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
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