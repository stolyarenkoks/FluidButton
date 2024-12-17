#!/usr/bin/env bash

# Получаем полную дату в формате: "January 7, 2025"
FULL_DATE=$(date +"%B %d, %Y")

# Обновляем LICENSE файл, заменяя только дату
sed -i "s/Copyright © [A-Za-z]* [0-9]*, [0-9]*\(.*\)$/Copyright © $FULL_DATE\1/" LICENSE
echo "Updated LICENSE file:"
cat LICENSE  # Отладка: выводим содержимое LICENSE

# Обновляем README.md файл, заменяя только дату
sed -i "s/Copyright © [A-Za-z]* [0-9]*, [0-9]*\(.*\)$/Copyright © $FULL_DATE\1/" README.md
echo "Updated README.md file:"
cat README.md  # Отладка: выводим содержимое README.md
