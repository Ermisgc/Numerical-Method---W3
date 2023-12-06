[S,interval] = adapt("funq3",0,3,0.00001);

x = linspace(0,3,1000);
y = funq3(x);
plot(x,y);
hold on
grid on
plot(interval,0,'Marker','+','Color','k');
xlabel("x");
ylabel("y");
