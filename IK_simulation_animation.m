clc ;
clear ;
close all ;

px = zeros(1,5);
py = zeros(1,5);
pz = zeros(1,5);
h = 0.29;
r = 0.159; 

origin = [ 0 ; r ; h ] ; %0 position
px(1) = origin(1) ; py(1) = origin(2) ; pz(1) = origin(3) ; %start trajectory at origin

p1 = [ 0.1 0.05 0.05 ] ; %position within range 
p2 = [ 0.3 0.2 0.2 ] ; %position outside of range

px(2) = p1(1) ; py(2) = p1(2) ; pz(2) = p1(3) ;
px(3) = origin(1) ; py(3) = origin(2) ; pz(3) = origin(3) ;
px(4) = p2(1) ; py(4) = p2(2) ; pz(4) = p2(3) ;
px(5) = origin(1) ; py(5) = origin(2) ; pz(5) = origin(3) ;

dx_pts = zeros(1,length(px));
dy_pts = dx_pts ;
dz_pts = dx_pts ;
theta3_pts = dx_pts ;

for i = 2:length(dx_pts)
   if abs(px(i)) > r
      if px(i) > r
          dx_pts(i) = px(i)-r ;
      else 
          dx_pts(i) = px(i)+r ;
      end
   else
       dx_pts(i) = 0;
   end
   
    theta3_pts(i) = asin((dx_pts(i)-px(i))/r);
    
    if theta3_pts(i) == 0
        dy_pts(i) = py(i)-r ;
    else
        dy_pts(i) = py(i)-((dx_pts(i)-px(i))/tan(theta3_pts(i)));
    end
    dz_pts(i) = pz(i) - h ;
end

num_pts = 100 ; 
quer_pts = linspace(0,length(dx_pts)-1,num_pts);
dx = interp1(0:length(dx_pts)-1,dx_pts,quer_pts);
dy = interp1(0:length(dy_pts)-1,dy_pts,quer_pts);
dz = interp1(0:length(dz_pts)-1,dz_pts,quer_pts);
theta3 = interp1(0:length(theta3_pts)-1,theta3_pts,quer_pts);


v = VideoWriter('ani.mp4');
v.FrameRate = 10;
open(v);

%for i = 1:length(dx)
figure()
for i = 1:num_pts
    %coordinates of origins of frame coordinate axes
    or0 = [0 0 0];
    or1 = [0 dy(i) 0];
    or2 = [dx(i) dy(i) 0];
    or3 = [dx(i) dy(i) 0];
    or4 = [dx(i)-(r*sin(theta3(i))) dy(i)+(r*cos(theta3(i))) h+dz(i)];
    
    %directions of frame coordinate axes
    x0 = [1 0 0]; z0 = [0 0 1];
    x1 = [0 0 1]; z1 = [0 1 0];
    x2 = [0 1 0]; z2 = [1 0 0];
    x3 = [-sin(theta3(i)) cos(theta3(i)) 0]; z3 = [0 0 1];
    x4 = [-sin(theta3(i)) cos(theta3(i)) 0]; z4 = [0 0 -1];
    
    %end points of each beam
    fin1 = or1 ;
    fin2 = or2 ;
    fin3 = [or3(1) or3(2) h];
    fin4 = [or4(1) or4(2) h] ;
    fin5 = or4 ;
    
    %plot links
    plot3([or0(1) fin1(1)],[or0(2) fin1(2)], [or0(3) fin1(3)],'k','LineWidth',1.5)
    hold on
    plot3([fin1(1) fin2(1)],[fin1(2) fin2(2)],[fin1(3) fin2(3)],'k','LineWidth',1.5)
    plot3([fin2(1) fin3(1)],[fin2(2) fin3(2)],[fin2(3) fin3(3)],'k','LineWidth',1.5)
    plot3([fin3(1) fin4(1)],[fin3(2) fin4(2)],[fin3(3) fin4(3)],'k','LineWidth',1.5)
    plot3([fin4(1) fin5(1)],[fin4(2) fin5(2)],[fin4(3) fin5(3)],'b','LineWidth',1.5)
    
    %plot coordinate axes
    alen = 0.05;
    
    %frame 0
    plot3([or0(1) x0(1)*alen], [or0(2) x0(2)*alen], [or0(3) x0(3)*alen],'g','LineWidth',1)%frame 0 x
    plot3([or0(1) z0(1)*alen], [or0(2) z0(2)*alen], [or0(3) z0(3)*alen],'r','LineWidth',1)%frame 0 z
    
    %frame 1
    plot3([or1(1) or1(1)+(x1(1)*alen)], [or1(2) or1(2)+(x1(2)*alen)], ...
    [or1(3) or1(3)+(x1(3)*alen)],'g','LineWidth',1) %frame 1 x
    plot3([or1(1) or1(1)+(z1(1)*alen)], [or1(2) or1(2)+(z1(2)*alen)], ...
    [or1(3) or1(3)+(z1(3)*alen)],'r','LineWidth',1) %frame 1 z

    %frame 2
    plot3([or2(1) or2(1)+(x2(1)*alen)], [or2(2) or2(2)+(x2(2)*alen)], ...
    [or2(3) or2(3)+(x2(3)*alen)],'g','LineWidth',1) %frame 2 x
    plot3([or2(1) or2(1)+(z2(1)*alen)], [or2(2) or2(2)+(z2(2)*alen)], ...
    [or2(3) or2(3)+(z2(3)*alen)],'r','LineWidth',1) %frame 2 z
%     
    %frame 3
    plot3([or3(1) or3(1)+(x3(1)*alen)], [or3(2) or3(2)+(x3(2)*alen)], ...
    [or3(3) or3(3)+(x3(3)*alen)],'g','LineWidth',1) %frame 3 x
    plot3([or3(1) or3(1)+(z3(1)*alen)], [or3(2) or3(2)+(z3(2)*alen)], ...
    [or3(3) or3(3)+(z3(3)*alen)],'r','LineWidth',1) %frame 3 z

    %frame 4
    plot3([or4(1) or4(1)+(x4(1)*alen)], [or4(2) or4(2)+(x4(2)*alen)], ...
    [or4(3) or4(3)+(x4(3)*alen)],'g','LineWidth',1) %frame 3 x
    plot3([or4(1) or4(1)+(z4(1)*alen)], [or4(2) or4(2)+(z4(2)*alen)], ...
    [or4(3) or4(3)+(z4(3)*alen)],'r','LineWidth',1) %frame 3 z
    
    %plot target points
    plot3(p1(1),p1(2),p1(3),'*r')
    plot3(p2(1),p2(2),p2(3),'*r')
       
    xlabel('x','Interpreter','Latex');ylabel('y','Interpreter','Latex');zlabel('z','Interpreter','Latex')
    xlim([-0.5 0.5]);ylim([-0.5 0.5]);zlim([-0.5 0.5])
    set(gca,'TickLabelInterpreter','Latex')
    axis square
    hold off
    grid on
    pause(0.01);

    frame = getframe(gcf);
    writeVideo(v,frame);
    
end
close(v)
