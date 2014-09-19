clear
clc
load finalnetvar1.mat;
for i=1:10
    for j=1:80
        if(i==1)
            fnip(j,i)=date(j,i);
        end
        if(i==2)
            usdchfintrare1=cell2mat(usdchfintrare);
            fnip(j,i)=usdchfintrare1(1,j);
        end
        if(i==3)
            usdgbpintrare1=cell2mat(usdgbpintrare);
            fnip(j,i)=usdgbpintrare1(1,j);
        end
        if(i==4)
            usdaudintrare1=cell2mat(usdaudintrare);
            fnip(j,i)=usdaudintrare1(1,j);
        end
        if(i==5)
            usdcadintrare1=cell2mat(usdcadintrare);
            fnip(j,i)=usdcadintrare1(1,j);
        end
        if(i==6)
            usdjpyintrare1=cell2mat(usdjpyintrare);
            fnip(j,i)=usdjpyintrare1(1,j);
        end
        if(i==7)
            crudeoilintrare1=cell2mat(crudeoilintrare);
            fnip(j,i)=crudeoilintrare1(1,j);
        end
        if(i==8)
           goldintrare1=cell2mat(goldintrare);
           fnip(j,i)=goldintrare1(1,j)
        end
        if(i==9)
            inflationintrare1=cell2mat(inflationintrare);
            fnip(j,i)=inflationintrare1(1,j);
        end
        if(i==10)
            cpiintrare1=cell2mat(cpiintrare);
            fnip(j,i)=cpiintrare1(1,j);
        end
    end
end

