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
8. Dividir a operacao do jogo em comandos simples que execute parte dos jogos como funcoes especificas
9. Desenvolver forma de salvar os chutes do usuario e o impedir de repetir chutes ja usados 
10. Desenvolver forma de salvar o progresso do jogo.



8. a) Estou reescrevendo a funcao play_round, quanto a ela, tenho duas ideias do que posso fazer e fico me confundindo sem decidir nenhuma das duas
   b) A primeira opcao e fazer play_round jogar o primeiro round, alterando apenas variaveis de classe pra nao nao ter que retornar valor nenhum entre nenhuma das funcoes
   c) A segunda opcao e fazer uma funcao chamada first_round, que joga o round, mostra o placar e no final retorna um valor para ser usado na funcao following_round que vai fazer praticamente a mesma coisa: joga o round, concatena a string do ultimo chute junto desse chute, para ai entao mostrar o placar e **nao retornar valor**