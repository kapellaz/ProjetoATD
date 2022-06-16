function [ID,Start,End] = leituraLabel(file,ficheiros)
    ID = zeros(1,1);
    Start = zeros(1,1);
    End = zeros(1,1);
    flabel = fopen(file,'r');
    formato = '%d %d %d %d %d';
    label = fscanf(flabel,formato);
    fclose(flabel);
    contador = 1;
    
    for k=1:5:length(label)
        
        
        if(label(k) > ficheiros)
            break
        end    
        if(label(k) == ficheiros)
            ID(contador) = label(k+2);
            Start(contador) = label(k+3);
            End(contador) = label(k+4);
            contador = contador + 1;
        end
    end  

end

