#!/bin/bash

handle_choice(){
	case ${choice} in
		#Add Passwordの場合
		"Add Password")
			echo "サービス名を入力してください:"
			read service_name
			echo "ユーザー名を入力してください:"
			read username
			echo "パスワードを入力してください:"
			read -s password
			echo "${service_name}:${username}:${password}" >> ${manage_file}

			echo -e '\n'
			ESC=$(printf '\033') # \e や \x1b または $'\e' は使用しない
			printf "${ESC}[32m%s${ESC}[m\n" '保存に成功しました！'
			;;
			
		#Get Passwordの場合
		"Get Password")
			echo "サービス名を入力してください:"
			read service_name
			if grep "${service_name}" "${manage_file}"; then
				echo "サービス名:${service_name}" 
				user_name=$(grep "${service_name}" "${manage_file}" | cut -d ':' -f 2)
				echo "ユーザー名:${user_name}" 
				password=$(grep "${service_name}" "${manage_file}" | cut -d ':' -f 3)
				echo "パスワード:${password}" 
			else
				echo "そのサービスは登録されていません"
			fi
			;;
			
		#Exitの場合
		"Exit")
			echo "Thank you!"
			exit 0
			;;
			
		*)
			echo -e '\n'
			ESC=$(printf '\033') # \e や \x1b または $'\e' は使用しない
			printf "${ESC}[31m%s${ESC}[m\n" '入力が間違えています。Add Password/Get Password/Exit から入力してください。'
			;;
	esac
}

main(){
	manage_file="manager.txt"	

	while true; do
		echo -e '\n'
		echo "パスワードマネージャーへようこそ！"
		read -p "次の選択肢から入力してください(Add Password/Get Password/Exit):" choice
		handle_choice "${choice}"
	done
}

main