#!/usr/bin/env Rscript	

caminhoDoArquivoCsv <- 'C:\\Users\\rodrigo\\Documents\\Color-Parts\\planilha_dd.csv';
dados <- read.csv(caminhoDoArquivoCsv, header=TRUE, sep=",", row.names=NULL);

dados

# las
# controla a direção das legendas dos eixos 
# las=1 -> legendas escritas sempre na horizontal
# las=3 -> legendas sempre na vertical
par(las=1)

# cex tamanho das fontes 
par(cex=1)

# par(mfrow=c()) controla “quantas figuras” serão desenhadas dentro de um mesmo dispositivo
# linhs , colunas
par(mfrow=c(1,1))

#par(mar=c()) controla o “tamanho das margens do dispositivo (pdf ou img)
# 1° numero controla a margem da parte de baixo do gráfico, 
# 2° controla a margem do lado esquerdo, 
# 3° numero controla a parte de cima e 
# 4° numero controla o tamanho da margem do lado direito do gráfico. 
par(mar=c(8,5,2,6))

#Grafico de barras
#se o arquivo dde dados tem x registros de jogadas, 
# esse vetor vem com uma numeracao de 1 a x onde x é a contagem dos registros de jogadas
# esse vetor é interessantes sempre que em gráficos queremos mostrar em qual jogada, por exemplo o dados se refere
cSeqDeJogasNumeradas <- c(seq(1,nrow(dados),by=1))

criaGraficoDeBarras <- function(variavel, descVariavel){
	#cria grafico de barras
	xx <- barplot(
		variavel, # dados do grafico
		#main="Tempo Total", #titulo do grafico
		#xlab="Tempo Total em segundos" , #rotulo do eixo x
		#ylab="N. de Jogadas", #rotulo do eixo y
		#names.arg=cSeqDeJogasNumeradas, #nomeia cada uma das barras com o numero de jogadas
		horiz=T) #torna o graf horizontal
	
	title(
		main="Pontuacao Total de Cada Jogada", col.main="blue", 
		sub="Pontuacao Total para todos os 4 objetos", col.sub="blue", 
		xlab=descVariavel, 
		ylab="Jogadas",
		col.lab="red", #Cor do label dos eixos 
		cex.lab=0.75) 
	
	# Escreve rotulo dos valores	
	text(
		y = xx, 
		x = variavel, 
		label = format(round(variavel, 3), nsmall = 3), 
		pos = NULL, 
		cex = 0.8, #tamanho da fonte do rotulo 
		col = "red")
	#box();
}


criaHitograma <- function(variavel, descVariavel){
	#histograma todos os alunos
	hist(variavel,
		main=paste("Histograma: ", descVariavel, sep=":"),
		freq=F, #eixo x mostra probabilidade ao inves de frequencia
		xlab=descVariavel,
		ylab="Propabilidade")
	lines(
		density(variavel), 
		col=2, #cor
		lwd=4) #Line width
	title(
		sub=descVariavel, col.sub="blue", 
		col.lab="red", #Cor do label dos eixos 
		cex.lab=0.75) 
}


criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores <- function(variavel, var2, strDescVar2){
	#Dispersão dos valores
	#boxplot
	
	#Na caixa temos 50% dos dados segundo e terceiro quartil
	#Linhas paralelas que determinam o primeiro quartil (valor mínimo até o segundo quartil)
	## Add text at top of bars
	boxplot(variavel ~ var2, ylab="Tempo Total" , xlab=strDescVar2)
	box()
}

#ANALISE DOS JOGADORES COM RELACAO AO TEMPO TOTAL
criaGraficoDeBarras(dados$pontos_total, "Total de Pontos") 
criaHitograma(dados$pontos_total, "Total de Pontos")
criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$pontos_total , dados$nome, "nome dos Jogadores")
criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$pontos_total , dados$fase, "Nome das Fases do Jogo")

par(mfrow=c(2,2))
#ANALISE DOS JOGADORES COM RELACAO AS FIGURAS ESPECIFICAS
criaGraficoDeBarras(dados$pontos_verde, "Pontuacao cor verde") 
criaGraficoDeBarras(dados$pontos_azul, "Pontuacao cor azul")
criaGraficoDeBarras(dados$pontos_amarelo, "Pontuacao cor amarelo")
criaGraficoDeBarras(dados$pontos_vermelho , "Pontuacao cor vermelho")

criaHitograma(dados$pontos_verde, "Pontuacao cor verde")
criaHitograma(dados$pontos_azul, "Pontuacao cor azul")
criaHitograma(dados$pontos_amarelo, "Pontuacao cor amarelo")
criaHitograma(dados$pontos_vermelho, "Pontuacao cor vermelho")


# criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$cilindro)
# criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$esfera)
# criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$cubo)
# criaBoxPlotsEmUmMesmoGraficoParaTodosOsJogadores(dados$capsula)




graficosLinearEvolucaoDoTempoTotal <- function(){
	#png(filename="graficosLinearEvolucaoDoTempoTotal.png")	
	plot(dados$tempo_total, ylab="Tempo Total" , xlab="esfera")
	#dev.off()	
}

geraGrafico_De_Dispersao_Esfera_X_TempoTotal <- function(){
	#png(filename="graficos_tpoTotal_tpoEsfera.png")
	#modelTpoTotal_x_TpoEsfera <- lm(dados$tempo_total ~ dados$esfera )	
	plot(dados$tempo_total ~ dados$esfera, ylab="Tempo Total" , xlab="esfera")
	#Sabline(modelTpoTotal_x_TpoEsfera)		
	#dev.off()
}

geraGrafico_De_Dispersao_Capsula_X_TempoTotal <- function(){
	#png(filename="graficos_tpoTotal_tpoCapsula.png")
	#modelTpoTotal_x_TpoCapsula <- lm(dados$tempo_total ~ dados$capsula )	
	plot(dados$tempo_total ~ dados$capsula, ylab="Tempo Total" , xlab="capsula")
	#abline(modelTpoTotal_x_TpoCapsula)		
	#dev.off()
}


geraGrafico_De_Dispersao_Cilindro_X_TempoTotal <- function(){
	#png(filename="graficos_tpoTotal_tpoCilindro.png")
	#modelTpoTotal_x_TpoCilindro <- lm(dados$tempo_total ~ dados$cilindro )	
	plot(dados$tempo_total ~ dados$esfera, ylab="Tempo Total" , xlab="Cilindro")
	#abline(modelTpoTotal_x_TpoCilindro)		
	#dev.off()
}


geraGrafico_De_Dispersao_Cubo_X_TempoTotal <- function(){
	#png(filename="graficos_tpoTotal_tpoCubo.png")
	#modelTpoTotal_x_TpoCubo <- lm(dados$tempo_total ~ dados$cubo )	
	plot(dados$tempo_total ~ dados$cubo, ylab="Tempo Total" , xlab="cubo")
	#abline(modelTpoTotal_x_TpoCubo)		
	#dev.off()
}


geraGraficoLinearDoTempoTotal <- function(){	
	geraGraficoLinearDoTempoTotal();
	#geraGrafico_De_Dispersao_Esfera_X_TempoTotal();
	#geraGrafico_De_Dispersao_Capsula_X_TempoTotal();
	#geraGrafico_De_Dispersao_Cilindro_X_TempoTotal();
	#geraGrafico_De_Dispersao_Cubo_X_TempoTotal();
}


#geraGraficoLinearDoTempoTotal();
