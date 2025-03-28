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
7. Desenvolver a classe responsavel por jogar o jogo, mostrar o progresso do jogo, o local das palavras e o tamanho ( )
representado por _. ( )
8. Desenvolver forma de salvar os chutes do usuario e o impedir de repetir chutes ja usados 
8. Desenvolver forma de salvar o progresso do jogo.

Mini-rewrite:

1. Faca da funcao play_round uma funcao que altere variaveis de classe
2. O proposito disso e fazer com que esta funcao jogue todos os rounds, nao apenas o round inicial.
3. Por alterar variavel de classe, podemos fazer o primeiro loop verificando primeiro se a nossa nova variavel de classe que vai ficar com o resultado do play_round, para so entao operarmos os turnos subsequentes que devem ser iguais
4. Isto e, o primeiro turno e unico, depois disso o loop devera ser o mesmo para todos os loops subsequentes ate o final do jogo.
