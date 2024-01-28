using Plots
using FFTW
using DSP

#Goal: Graph several time domain gaussian filters with different vals of sig

function gaussian(range, sig)

	holder = Float64[]

	for x in range

		new = 1/(sig*sqrt(2*pi))*(abs.(exp((-x^2)/(2 .* sig^2)))) #gaussian function w/o( 1/(sig*sqrt(2*pi)) factor
		push!(holder, new)

	end 

	return holder

end 

#first graph
x = LinRange(-50, 50, 1000)
sig_1 = 1 #sigma
f1 = gaussian(x, sig_1)

#second graph
sig_2 = 4
f2 = gaussian(x,sig_2)

#third graph
sig_3 = 15
f3 = gaussian(x,sig_3)

big_gauss=[f1, f2, f3]
sig_array = [sig_1, sig_2, sig_3]

for i in 1:3

	plot!(x, big_gauss[i], title="Gaussian Filters", xlabel="Time (s)", ylabel="Amplitude", label="σ = $(sig_array[i])")
end

savefig("gaussians_time.png")