ipv6_file=$1

cd ~/doq/data/input

# split input file into 5 files
split -n l/5 --numeric-suffixes=1 $ipv6_file input_
