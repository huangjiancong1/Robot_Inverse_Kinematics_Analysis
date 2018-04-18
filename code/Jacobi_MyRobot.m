% Author: huangjiancong
% Function: Caculate the Jacobi matrix
% Date: 2018/04/18

function J=Jacobi_MyRobot(th1,dz,th3,th4,th5,th6)
global Link

jsize=6;
J=zeros(6,jsize);

 Link(2).th=th1*pi/180;
 Link(3).dz=dz+100;
 Link(4).th=th3*pi/180;
 Link(5).th=th4*pi/180;
 Link(6).th=th5*pi/180;
 Link(7).th=th6*pi/180;

for i=1:7
Matrix_DH_Ln(i);
end

Link(1).p=Link(1).p(1:3);
for i=2:7
      Link(i).A=Link(i-1).A*Link(i).A;
      Link(i).p= Link(i).A(1:3,4);
      Link(i).n= Link(i).A(:,1);
      Link(i).o= Link(i).A(:,2);
      Link(i).a= Link(i).A(:,3);
      Link(i).R=[Link(i).n(1:3),Link(i).o(1:3),Link(i).a(1:3)];
end

target=Link(7).p;
a = Link(1).R*Link(1).az;
J(:,1)=[cross(a,target-Link(1).p); a];
J(:,2)=[Link(2).R*Link(2).az;0;0;0];
for n=3:jsize
     a=Link(n).R*Link(n).az;  
     J(:,n)=[cross(a,target-Link(n).p); a];
end
