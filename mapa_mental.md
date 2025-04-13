O que fazer.

Projeto agora e criar o jogo da forca.

Tenho uma lista de 10000 palavras e preciso escolher apenas aquelas entre 5 e 12
caracteres. Gostaria de comecar a trabalhar com classes pra limpar mais meu codigo.

1. Serializar o arquivo. O formato e uma palavra por linha. (X)
2. Selecionar apenas palavras entre 5-12 caracters. (X)
3. Fazer um metodo que escolha uma palavra aleatoria. Como o formato sera uma array
o metodo .sample deve bastar. (X)
4. Criar texto de apresentacao inicial mostrando as regras de hangman. (X)
5. Desenvolver uma forma de comparar as suposicoes. Case insensitive. (X)
6. Desenvolver uma forma de manter o placar. (X)
7. Desenvolver a classe responsavel por jogar o jogo, mostrar o progresso do jogo, o local das palavras e o tamanho 
representado por _. (X)
8. Dividir a operacao do jogo em comandos simples que execute parte dos jogos como funcoes especificas (X)
9. Desenvolver calculo e operacao de placar e fim de jogo (X)
10. Desenvolver forma de salvar os chutes do usuario (X)
11. Desenvolver forma de salvar o progresso do jogo. ()


a) Crie uma funcao que serializa todas as variaveis ()
b) Escreva a serializacao em um arquivo()
c) Escreva outra funcao para ler essa serializacao e implementar o valor das variaveis()
d) Escreva outra funcao para lidar com os saves
e) De opcoes limitadas de saves, para simplicidade pode criar 5 saves e serializa-los todos juntos para dar opcao de ate X saves

Para o processo de serializacao, vamos ter de re-estudar os propositos de nossas classes e redesignar conforme necessario.

A principio, a classe Comparison esta atuando com dois tipos diferentes de data types, o que dificulta na serializacao. Seu objetivo agora e

1- Analise o codigo, analise a utilizacao de classes. A classe Comparison precisa ser inicializada com ''? Nao pode ter valor padrao?
2- Por que duas variaveis Comparisons sao inicializadas, mas depois uma delas se transforma em string normal? Sera necessario?
3- Pesquisando sobre boas-praticas, o proximo passo antes de poder completar esse projeto vai ser a re-examinacao do codigo para manter (ou nao) a integridade das classes que voce criou.