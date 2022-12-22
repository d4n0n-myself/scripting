#!/bin/bash

# Обработка аргументов
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --path)
      DIRPATH="$2"
      shift # past argument
      shift # past value
      ;;
    --mask)
      MASK="$2"
      shift # past argument
      shift # past value
      ;;
    --number)
      NUMBER="$2"
      shift # past argument
      shift # past value
      ;;
    *) # остальные аргументы считаем командой
      COMMAND="$1"
      shift # past argument
      ;;
  esac
done

# Если не указан путь к каталогу, то используем текущий рабочий каталог
if [ -z "$DIRPATH" ]
then
  DIRPATH="$(pwd)"
fi

# Если не указан маска файлов, то используем "*"
if [ -z "$MASK" ]
then
  MASK="*"
fi

# Если не указано максимальное количество процессов, то используем количество ядер CPU
if [ -z "$NUMBER" ]
then
  NUMBER="$(nproc)"
fi

# Проверка, что указана команда
if [ -z "$COMMAND" ]
then
  echo "Не указана команда" >&2
  exit 1
fi

# Проверка, что каталог существует
if [ ! -d "$DIRPATH" ]
then
  echo "Каталог $DIRPATH не существует" >&2
  exit 1
fi

# Определение списка файлов для обработки
FILES=($(find "$DIRPATH" -maxdepth 1 -name "$MASK" -type f))

# Обработка файлов
for file in "${FILES[@]}"; do
  # Проверка, что количество запущенных процессов меньше максимального
  while [ "$(jobs | wc -l)" -ge "$NUMBER" ]
  do
    sleep 1
  done

  # Запуск команды на обработку файла
  "$COMMAND" "$file" &
done

# Ожидание завершения всех процессов
wait
