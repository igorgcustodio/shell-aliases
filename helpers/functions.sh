# Functions

function measure() {
    start_time=`date +%s`;
    $@;
    end_time=`date +%s`;
    final_time=$(($end_time - $start_time));
    logGreen "Run time is: ${final_time}s";
}

function cpf() {
    python3 -c 'import random;
cpf = [random.randint(0, 9) for x in range(9)]
for _ in range(2):
    val = sum([(len(cpf) + 1 - i) * v for i, v in enumerate(cpf)]) % 11
    cpf.append(11 - val if val > 1 else 0)
print("%s%s%s.%s%s%s.%s%s%s-%s%s"%tuple(cpf))
' | pbcopy
}

function cnpj() {
    python3 -c 'import random;
def calculate_special_digit(l):
    digit = 0
    for i, v in enumerate(l):
        digit += v * (i % 8 + 2)
    digit = 11 - digit % 11
    return digit if digit < 10 else 0
cnpj = [1, 0, 0, 0] + [random.randint(0, 9) for x in range(8)]
for _ in range(2):
    cnpj = [calculate_special_digit(cnpj)] + cnpj
print("%s%s.%s%s%s.%s%s%s/%s%s%s%s-%s%s"%tuple(cnpj[::-1]))
' | pbcopy
}

function cleandata() {
    echo "Cleaning Xcode derived data..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/* 
    echo "Done!"
}

function fixconflict() {    
    filesWithConflict=("${(@f)$(git status --short | grep "^UU ")}")

    echo "\033[0;33m \033[1mWere found ${#filesWithConflict[@]} conflicted files!"

    for file in "${filesWithConflict[@]}"; do
        fileSanitized="${file##UU }"

        filenameWithoutPath=(${(@s:/:)fileSanitized})
        echo "Opening $filenameWithoutPath[${#filenameWithoutPath[@]}] ..."           
        
        # Change to your favorite text editor 😎 e.g. sublime, vim etc.
        code $fileSanitized
    done
}