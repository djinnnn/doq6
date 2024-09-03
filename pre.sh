ipv6_file=$1

mkdir -p ~/wy/Projects/DoQ/ipv6/data


mkdir -p ~/wy/Projects/DoQ/ipv6/data/input
cd ~/wy/Projects/DoQ/ipv6/

if [ -f ~/wy/Projects/DoQ/ipv6/$ipv6_file ]; then
  mv ~/wy/Projects/DoQ/ipv6/$ipv6_file ~/wy/Projects/DoQ/ipv6/data/input
else
  echo "File $ipv6_file does not exist."
  exit 1
fi

cd ~/wy/Projects/DoQ/ipv6/data/input
# split input file into 5 files
split -n l/5 --numeric-suffixes=1 $ipv6_file input_
