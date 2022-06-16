sensores = ["ACC-X","ACC-Y","ACC-Z"];

atividade = ["W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"];

labels = importdata("RawData/labels.txt"); % Importa a data das labels

Fs = 50; %Hz de acordo com o enunciado

conta_users=1;
k=1;

%%ex1 e 2
while k<9

    control = 0;
    file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(k),string(conta_users));

    if isfile(file)
        info = importdata(file);
        this_labels = intersect(find(labels(:,1) ==k), find(labels(:,2)==conta_users));
        time = (0:size(info)-1)./Fs;

        [lines,n_acc] = size(info);

        % Desenha 10 figuras independentes
        figure;
        
        for i=1:n_acc %3 graficos por figura
            subplot(n_acc,1,i);
            plot(time./60, info(:,i), "k--");
            xlabel("Time(min)", "fontSize",8, "FontWeight","bold");
            ylabel(sensores(i),"fontSize",8, "FontWeight","bold");
            hold on
            for j=1: numel(this_labels)
                plot(time(labels(this_labels(j),4):labels(this_labels(j),5))./60,info(labels(this_labels(j),4):labels(this_labels(j),5),i));
                if mod(j,2) ==1 %escreve em baixo
                    y=min(info(:,i));
                else %escreve em cima
                    y = max(info(:,i));
                end
                text(time(labels(this_labels(j),4))./60,y,atividade(labels(this_labels(j),3)),"VerticalAlignment","top","HorizontalAlignment","left");
            end
        end
        hold off

    else
        conta_users=conta_users+1;
        k=k-1;
    end
    k=k+1;
end
%% Ex3
%

sensores = ["ACC-X","ACC-Y","ACC-Z"];

atividade = ["W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"];

labels = importdata("RawData/labels.txt"); % Importa a data das labels

Fs = 50; %Hz de acordo com o enunciado

conta_users=1;
k=1;
while k<9
    control = 0;
    file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(k),string(conta_users));

    if isfile(file)
        info = importdata(file);
        figure
        dft(conta_users,k , Fs, sensores);

    else
        conta_users=conta_users+1;
        k=k-1;
    end
    k=k+1;
end
%% ex 4 Leitura dos dados
fs=50;
user=1;
exp=1;
acao=1;
tam=0;
nome_fich = sprintf("RawData/acc_exp0%s_user0%s.txt",string(exp),string(user));
labels = importdata("RawData/labels.txt");
if isfile(nome_fich)
    %leitura dos dados da atividade
    info = importdata(nome_fich);
    info_atividade = intersect(intersect(find(labels(:,1) ==exp), find(labels(:,2)==user)), find(labels(:,3)==acao));
    for i=1:size(info_atividade)
        tam=tam + labels(info_atividade(i),5)-labels(info_atividade(i),4);
    end
    dados_atividade = zeros([1,tam]);
    tam=1;
    for i=1:size(info_atividade)
        inicio=labels(info_atividade(i),4);
        fim=labels(info_atividade(i),5);
        for j=1:labels(info_atividade(i),5)-labels(info_atividade(i),4)
            dados_atividade(tam)=info(inicio,3);
            inicio=inicio+1;
            tam=tam+1;
        end
    end
    ham = hamming(tam);
    PlotDFTWindow(dados_atividade,ham,"HAMMING");
end
%% CALCULO DA STFT   
%opts = {'Window',kaiser(50,150),'OverlapLength',30,'FrequencyRange',"centered"};
%opts = {'Window',rectwin(50),'OverlapLength',30,'FrequencyRange',"centered"};
 %inicio da aplicacoa das transformadas

    opts ={'Window',hamming(50,'periodic'),'OverlapLength',20,'FrequencyRange',"centered"};
    [~,f] = stft(dados_atividade,fs,opts{:});

    subplot(1,1,1)
    stft(dados_atividade,fs,opts{:})
    title(sprintf('''%s'': [%5.3f, %5.3f] kHz',"HAMMING ",[f(1) f(end)]/1000))
    %% 4.3 Aplicação da função ao todo
    info_total = importdata("RawData/acc_exp01_user01.txt");
    eixo_z_total= info_total(:,3).';
    opts ={'Window',hamming(50,'periodic'),'OverlapLength',20,'FrequencyRange',"centered"};
    [~,f] = stft(eixo_z_total,fs,opts{:});
    figure(1)
    stft(eixo_z_total,fs,opts{:})
    title(sprintf('''%s'': [%5.3f, %5.3f] kHz',"STFT ",[f(1) f(end)]/1000))
    %% fUNÇÃO PARA AS JANELAS   
  function PlotDFTWindow(dados,janela,titulo)
    f=linspace(-25,25,numel(dados));

    X = abs(fftshift(fft(detrend(dados.*janela))));    
    disp(length(f));
    plot(f,X),title(titulo),xlabel('F(Hz)'),ylabel('|DFT|');
    
end