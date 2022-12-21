#!/bin/bash

declare -a game
step=0
game=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 x)

game=($(echo "${game[@]}" | tr " " "\n" | shuf))

function draw_game {
    echo ""
    echo "+-------------------+"
    for i in {0..3}; do
        for j in {0..3}; do
            printf "|%-4s" " ${game[$((i*4+j))]}"
        done
        echo "|"
        if [[ $i != "3" ]]; then
	    echo "|-------------------|"
	fi
    done
    echo "+-------------------+"
    echo ""
}

function check_solution {
    if [ "${game[0]}" == "1" ] && [ "${game[1]}" == "2" ] && [ "${game[2]}" == "3" ] && [ "${game[3]}" == "4" ] &&
       [ "${game[4]}" == "5" ] && [ "${game[5]}" == "6" ] && [ "${game[6]}" == "7" ] && [ "${game[7]}" == "8" ] &&
       [ "${game[8]}" == "9" ] && [ "${game[9]}" == "10" ] && [ "${game[10]}" == "11" ] && [ "${game[11]}" == "12" ] &&
       [ "${game[12]}" == "13" ] && [ "${game[13]}" == "14" ] && [ "${game[14]}" == "15" ] && [ "${game[15]}" == "x" ]; then
        echo "Вы собрали головоломку за $step ходов."
        exit 0
    fi
}

function error {
    echo "Неверный ход!"
	echo "Невозможно костяшку $move передвинуть на пустую ячейку."
    pos_moves=($(echo "${game[$(($1-1))]}" "${game[$(($1+1))]}" "${game[$(($1-4))]}" "${game[$(($1+4))]}" | tr " " ","))
	echo "Можно выбрать: $pos_moves"
}

# Основной цикл игры
while true; do
    step=$((step+1))

    echo "Ход №$step"
    draw_game

    check_solution
 
    read -p "Ваш ход (q - выход): " move
    if [ "$move" == "q" ]; then
        exit 0
    fi

    # Поиск индекса элемента, который нужно переместить
    index=0
    for i in "${game[@]}"; do
        if [ "$i" == "$move" ]; then
            break
        fi
        index=$((index+1))
    done

    # Проверка, что элемент найден
    if [ "$index" -gt 15 ]; then
        echo "Неверный ход!"
        continue
    fi

    # Поиск индекса пустого элемента
    x_index=0
    for i in "${game[@]}"; do
        if [ "$i" == "x" ]; then
            break
        fi
        x_index=$((x_index+1))
    done

    # Проверка, что элемент можно переместить
    index_row="$((index / 4))"
    x_index_row="$((x_index / 4))"

    if [ $index_row != $x_index_row ]; then
        if [[ "$((index-x_index))" == -1 ]]; then
            error x_index
            continue
        elif [[ "$((index-x_index))" == 1 ]]; then
            error x_index
            continue
        fi
    fi

    if [ "$((index-x_index))" != 1 ] && [ "$((index-x_index))" != -1 ] && [ "$((index-x_index))" != 4 ] && [ "$((index-x_index))" != -4 ]; then
        error x_index
        continue
    fi

    # Обмен элементами
    temp=${game[$index]}
    game[$index]=${game[$x_index]}
    game[$x_index]=$temp
done

