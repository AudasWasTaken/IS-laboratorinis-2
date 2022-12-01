%A. Narmontas
%Lab 2 Papildoma

clear all
close all
x = 0.1:1/22:1;
x2 = 0.1:1/22:1;
indx = 1;
d = zeros(20,20);
%xv = 0.1:1/444:1;

for eil = 1:20
    for stulp = 1:20
        d(eil,stulp) = x(eil)^3-sin(2*pi*x2(stulp))^2;
        %d(c) = (1 + 0.6*sin(2*pi*x(c)/0.7)) + 0.3*sin(2*pi*x(c))/2;
        %indx = indx +1;

    end
end
figure(1)
surf(d);

%2. Sugeneruoti pradines rysiu svoriu reiksmes
%1 sluoksnio parametrai
w11_1 = randn(1); 
w21_1 = randn(1); 
w31_1 = randn(1); 
w41_1 = randn(1);
w51_1 = randn(1); 

w12_1 = randn(1); 
w22_1 = randn(1); 
w32_1 = randn(1); 
w42_1 = randn(1);
w52_1 = randn(1); 

b1_1 = randn(1);
b2_1 = randn(1);
b3_1 = randn(1);
b4_1 = randn(1);
b5_1 = randn(1);

%2 sluoksnio parametrai
w11_2 = randn(1); b1_2 = randn(1);
w12_2 = randn(1); 
w13_2 = randn(1); 
w14_2 = randn(1); 
w15_2 = randn(1); 

mok_zing = 0.15;

for indx=1:10000
    for eil = 1:20
        for stulp = 1:20
            %3. apskaiciuoti tinklo atsaka (momentini)
            %pasverta suma 1 sluoksnyje
            v1_1 = x(eil)*w11_1+x2(stulp)*w12_1+b1_1;
            v2_1 = x(eil)*w21_1+x2(stulp)*w22_1+b2_1;
            v3_1 = x(eil)*w31_1+x2(stulp)*w32_1+b3_1;
            v4_1 = x(eil)*w41_1+x2(stulp)*w42_1+b4_1;
            v5_1 = x(eil)*w51_1+x2(stulp)*w52_1+b5_1;

            %aktyvavimo funkcija 1 sluoksnyje
            y1_1 = 1/(1+exp(-v1_1));
            y2_1 = 1/(1+exp(-v2_1));
            y3_1 = 1/(1+exp(-v3_1));
            y4_1 = 1/(1+exp(-v4_1));
            y5_1 = 1/(1+exp(-v5_1));
    
            %pasverta suma isejimo sluoksnyje
            v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2+b1_2;
    
            %skaiciuojama isejimo/tinklo atsaka pritaikydami aktyvavimo f-jas
            y1_apskaiciuota = v1_2;
    
            %4. Palyginti su norimu atsaku ir apskaiciuoti klaida
            e1 = d(eil,stulp) - y1_apskaiciuota;

            %5. Atnaujinti rysiu svorius taip, kad klaida mazetu (atlikti tinklo
            %mokyma)
            %formule: w = w+mok_zing*delta*input
            delta_out_1 = e1;
    
            delta_1_1 = y1_1*(1-y1_1)*(delta_out_1*w11_2);
            delta_2_1 = y2_1*(1-y2_1)*(delta_out_1*w12_2);
            delta_3_1 = y3_1*(1-y3_1)*(delta_out_1*w13_2);
            delta_4_1 = y4_1*(1-y4_1)*(delta_out_1*w14_2);
            delta_5_1 = y5_1*(1-y5_1)*(delta_out_1*w15_2);

            %atnaujinti svorius
            w11_2 = w11_2+mok_zing*delta_out_1*y1_1;
            w12_2 = w12_2+mok_zing*delta_out_1*y2_1;
            w13_2 = w13_2+mok_zing*delta_out_1*y3_1;
            w14_2 = w14_2+mok_zing*delta_out_1*y4_1;
            w15_2 = w15_2+mok_zing*delta_out_1*y5_1;
            b1_2 = b1_2 + mok_zing*delta_out_1;

            %atnaujinti svorius pasleptame sluoksnyje
            w11_1 = w11_1 + mok_zing*delta_1_1*x(eil); 
            w21_1 = w21_1 + mok_zing*delta_2_1*x(eil); 
            w31_1 = w31_1 + mok_zing*delta_3_1*x(eil); 
            w41_1 = w41_1 + mok_zing*delta_4_1*x(eil); 
            w51_1 = w51_1 + mok_zing*delta_5_1*x(eil); 

            w12_1 = w12_1 + mok_zing*delta_1_1*x2(stulp); 
            w22_1 = w22_1 + mok_zing*delta_2_1*x2(stulp); 
            w32_1 = w32_1 + mok_zing*delta_3_1*x2(stulp); 
            w42_1 = w42_1 + mok_zing*delta_4_1*x2(stulp); 
            w52_1 = w52_1 + mok_zing*delta_5_1*x2(stulp); 
            b1_1 = b1_1 +mok_zing*delta_1_1;
            b2_1 = b2_1 +mok_zing*delta_2_1;
            b3_1 = b3_1 +mok_zing*delta_3_1;
            b4_1 = b4_1 +mok_zing*delta_4_1;
            b5_1 = b5_1 +mok_zing*delta_5_1;
        end
        ciklas = indx;
        %disp(e1)
    end  
end
disp(ciklas)
disp(e1)
x = 0.1:1/220:1;
x2 = 0.1:1/220:1;
for eil = 1:199
    for stulp = 1:199
        %3. apskaiciuoti tinklo atsaka (momentini)
        %pasverta suma 1 sluoksnyje
        v1_1 = x(eil)*w11_1+x2(stulp)*w12_1+b1_1;
        v2_1 = x(eil)*w21_1+x2(stulp)*w22_1+b2_1;
        v3_1 = x(eil)*w31_1+x2(stulp)*w32_1+b3_1;
        v4_1 = x(eil)*w41_1+x2(stulp)*w42_1+b4_1;
        v5_1 = x(eil)*w51_1+x2(stulp)*w52_1+b5_1;
        %aktyvavimo funkcija 1 sluoksnyje
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));
        %pasverta suma isejimo sluoksnyje
        v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2+b1_2;
        %skaiciuojama isejimo/tinklo atsaka pritaikydami aktyvavimo f-jas
        y1_apskaiciuota(eil,stulp) = v1_2;
    end
end
figure(2)
surf(y1_apskaiciuota);