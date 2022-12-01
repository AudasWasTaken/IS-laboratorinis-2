%A. Narmontas
%Lab 2

clear all
close all
x = 0.1:1/22:1;


for c = 1:20
    d(c) = x(c)^3-sin(2*pi*x(c))^2;
    %d(c) = (1 + 0.6*sin(2*pi*x(c)/0.7)) + 0.3*sin(2*pi*x(c))/2;
end
disp(x)
disp(d)
figure(1)
plot(x,d,'r*');

w11_1 = randn(1); b1_1 = randn(1);
w21_1 = randn(1); b2_1 = randn(1);
w31_1 = randn(1); b3_1 = randn(1);
w41_1 = randn(1); b4_1 = randn(1);
w51_1 = randn(1); b5_1 = randn(1);
%2 sluoksnio parametrai
w11_2 = randn(1); b1_2 = randn(1);
w12_2 = randn(1); 
w13_2 = randn(1); 
w14_2 = randn(1); 
w15_2 = randn(1); 

mok_zing = 0.15;

for indx=1:10000
    for n = 1:20
        %3. apskaiciuoti tinklo atsaka (momentini)
        %pasverta suma 1 sluoksnyje
        v1_1 = x(n)*w11_1+b1_1;
        v2_1 = x(n)*w21_1+b2_1;
        v3_1 = x(n)*w31_1+b3_1;
        v4_1 = x(n)*w41_1+b4_1;
        v5_1 = x(n)*w51_1+b5_1;

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
        e1 = d(n) - y1_apskaiciuota;

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
        w11_1 = w11_1 + mok_zing*delta_1_1*x(n); 
        w21_1 = w21_1 + mok_zing*delta_2_1*x(n); 
        w31_1 = w31_1 + mok_zing*delta_3_1*x(n); 
        w41_1 = w41_1 + mok_zing*delta_4_1*x(n); 
        w51_1 = w51_1 + mok_zing*delta_5_1*x(n); 
        b1_1 = b1_1 +mok_zing*delta_1_1;
        b2_1 = b2_1 +mok_zing*delta_2_1;
        b3_1 = b3_1 +mok_zing*delta_3_1;
        b4_1 = b4_1 +mok_zing*delta_4_1;
        b5_1 = b5_1 +mok_zing*delta_5_1;
    end
    ciklas = indx;
    disp(e1)
end
disp(ciklas)
disp(e1)

for m = 1:20
    %3. apskaiciuoti tinklo atsaka (momentini)
    %pasverta suma 1 sluoksnyje
    v1_1 = x(m)*w11_1+b1_1;
    v2_1 = x(m)*w21_1+b2_1;
    v3_1 = x(m)*w31_1+b3_1;
    v4_1 = x(m)*w41_1+b4_1;
    v5_1 = x(m)*w51_1+b5_1;
    %aktyvavimo funkcija 1 sluoksnyje
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    y5_1 = 1/(1+exp(-v5_1));
    %pasverta suma isejimo sluoksnyje
    v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2+b1_2;
    %skaiciuojama isejimo/tinklo atsaka pritaikydami aktyvavimo f-jas
    y1_apskaiciuota(m) = v1_2;
end
figure,
plot(x,d,'kx',x,y1_apskaiciuota,'rx')