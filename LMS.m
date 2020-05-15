function[E] = LMS(u,m,noised_signal)
order = 12;       % order of the filter(maximum no.of delay elements)
mu = 0.0003642;     % It is constant(optimal value of mu value is calculated using experiments)
n = length(noised_signal);     %length of noised_signal signal
w = zeros(order,1);      %initializing vectors
E = zeros(1,m);
for k = 12:n
 U = u(k-11:k);
 y = U'*w;                % preliminary output signal 
 E(k) = noised_signal(k)-y;     % error
 w = w + mu*E(k)*U;       % calculating LMS fiter weights
end
