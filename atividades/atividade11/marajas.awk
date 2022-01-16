# Correção: 0,5. Não funciona se alterarmos o número de cursos. A parte da AWS Academy está OK.

BEGIN{
	i = 1
}
{
	
	nome_eng = ""
	nome_redes = ""
	nome_sis = ""
	for(j=1 ; j < NR ; j++){
	
		nome[i] = $(NF - 2)
		curso[i] = $(NF - 1) 
		salario[i] = $NF
		i = i + 1
	
	}
	
	Maior_eng = 0
	Maior_redes = 0
	Maior_sistemas = 0
	
	for(k = 1; k < i;k++){
	
		if( curso[k] == "Engenharia" ){
			if(salario[k] > Maior_eng){
				Maior_eng = salario[k]
				nome_eng = nome[k] " "
			}
		
		}else if(curso[k] == "Redes"){
			if(salario[k] > Maior_redes){
				Maior_redes = salario[k]
				nome_redes = nome[k] " "
			}
		
		
		}else if(curso[k] == "Sistemas"){
			if(salario[k] > Maior_sistemas){
				Maior_sistemas = salario[k]
				nome_sis = nome[k] " "
			}
		
		}
	
	}
	
	
	



}

END{

	printf "Engenharia: %s %d\n", nome_eng, Maior_eng
	printf "Redes: %s %d\n", nome_redes, Maior_redes
	printf "Sistemas: %s %d\n", nome_sis, Maior_sistemas
	



}
