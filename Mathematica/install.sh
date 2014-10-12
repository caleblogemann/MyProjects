# present working directory
MATHEMATICA_ROOT="$(pwd)"

# Mathematica path destination
MATHEMATICA_PATH="$HOME/Library/Mathematica/Applications/"

for package in "$MATHEMATICA_ROOT/"*.m; do
    ln -s "$package" "$MATHEMATICA_PATH";
done
