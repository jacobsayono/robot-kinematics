% MAE C163A/C263A Project
% Team 13 Robot Angler

% Initialize
initialize();
input('Press any key to continue!');

% definitions
x = 0;          % range: [-0.075 to +0.075]m max        1 rev = 0.008 m
y = 0;          % range: [-0.075 to +0.075]m max        1 rev = 0.008 m
t = 0;          % range: [-90 to +90] degrees max       0.5 rev
z = 0;          % range: [0 to 0.14]m max               1 rev = 0.1257 m

% Main
% DH joint angle unit rad
theta2 = (-x / 0.008) * 2 * pi;  % prismatic x
theta1 = (-y / 0.008) * 2 * pi;  % prismatic y
theta3 = t * (pi / 180);        % revolute
theta4 = (z / 0.1257) * 2 * pi; % prismatic z


Theta1 = theta1/2/pi*4096; % Motor angle 0-4095; You may also need to consider the offset, i.e., when theta1 = 0, Theta1 ~= 0.
Theta2 = theta2/2/pi*4096; % Motor angle 0-4095; You may also need to consider the offset, i.e., when theta1 = 0, Theta1 ~= 0.
Theta3 = theta3/2/pi*4096; % Motor angle 0-4095; You may also need to consider the offset, i.e., when theta1 = 0, Theta1 ~= 0.
Theta4 = theta4/2/pi*4096; % Motor angle 0-4095; You may also need to consider the offset, i.e., when theta1 = 0, Theta1 ~= 0.

% Move MX28_ID(1) to Theta1 angle
write4ByteTxRx(port_num, PROTOCOL_VERSION, MX28_ID(1), MX28_GOAL_POSITION, typecast(int32(Theta1), 'uint32'));
write4ByteTxRx(port_num, PROTOCOL_VERSION, MX28_ID(2), MX28_GOAL_POSITION, typecast(int32(Theta2), 'uint32'));
write4ByteTxRx(port_num, PROTOCOL_VERSION, MX28_ID(3), MX28_GOAL_POSITION, typecast(int32(Theta3), 'uint32'));
write4ByteTxRx(port_num, PROTOCOL_VERSION, MX28_ID(4), MX28_GOAL_POSITION, typecast(int32(Theta4), 'uint32'));

% Terminate
input('Press any key to terminate!');
terminate();