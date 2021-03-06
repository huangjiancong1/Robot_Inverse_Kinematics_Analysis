% Author: huangjiancong
% Function: Link my robot
% Date: 2018/04/18
function Link_J_MyRobot(th1,dz,th3,th4,th5,th6,fcla)
global Link

Build_MyRobot;
radius    = 15;  %25
len       = 40;  %60
joint_col = 0;

 Link(2).th= th1*pi/180;
 Link(3).dz=dz+100;
 Link(4).th=th3*pi/180;
 Link(5).th=th4*pi/180;
 Link(6).th=th5*pi/180;
 Link(7).th=th6*pi/180;

p0=[0,0,0]';


for i=1:7
Matrix_DH_Ln(i);
end


for i=2:7

      Link(i).A=Link(i-1).A*Link(i).A;
      Link(i).p= Link(i).A(:,4);
      Link(i).n= Link(i).A(:,1);
      Link(i).o= Link(i).A(:,2);
      Link(i).a= Link(i).A(:,3);
      Link(i).R=[Link(i).n(1:3),Link(i).o(1:3),Link(i).a(1:3)];
      Connect3D(Link(i-1).p,Link(i).p,'r',2); hold on;
       plot3(Link(i).p(1),Link(i).p(2),Link(i).p(3),'bx');hold on;
      if i<=7
          DrawCylinder(Link(i-1).p, Link(i-1).R * Link(i).az, radius,len, joint_col); hold on;
      end 
end
%view(125,52);
%set (gcf,'Position',[650,100,700,600])
axis([-550,550,-550,550,-300,550]);
xlabel('x');
ylabel('y'); 
zlabel('z');
grid on;
drawnow;
if(fcla)
    cla;
end