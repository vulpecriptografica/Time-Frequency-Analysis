using Plots
using FFTW
using DSP


#Goal: Graph DFTs of several Gaussian filters with different vals of sigma

#Gaussian stuff

function gaussian(range, sig)

	holder = Float64[]

	for x in range

		new = 1/(sig*sqrt(2*pi))*(abs.(exp((-x^2)/(2 .* sig^2)))) #gaussian function
		push!(holder, new)

	end 

	return holder

end 

#x-axis vals
bound = 50
num_pts = 1000
x = LinRange(-bound, bound, num_pts)

#first graph
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


#Fourier stuff

T = bound*2 #total duration of signal
dt = 0.020 #sampling period

function sampling_func(T,dt)
	    
	    sample_times=Float64[] #initialize empty array
	    n=0 #counter

	    while n*dt ≤ T
	        
	        append!(sample_times, [n*dt]) 
	        n += 1
	 
	    end #ends while loop
	    
	    return sample_times
	    
	        
	end


#Freqs that DFT is sampled at
function f_freq(fs, num_pts)
	    
	    LinRange(-0.5*fs, 0.5*fs, num_pts) # all frequencies in given range that DFT is sampled at
	    
	end
	        
fs = 1/dt #sampling frequency
#num_pts = length()+500 #+500 due to the zero-padding

pad = 100000

#Calling fxn
sampled_freqs = f_freq(fs, num_pts+pad)


#Fourier coefficients
function dtft_coeff(signal)
    
    #return fftshift(fft(signal))
    return fftshift(fft([signal;zeros(pad)])) #returns DTFT coefficients of input signal padded with 500 zeroes; fftshift puts 0 in middle of array
           
end



#Returns a plot of the DFT of an input function
function DFT_plot(x,y)

    plot(x,y, title="DTFT Plot", legend=false)
    xlabel!("Frequency (Hz)")
    ylabel!("Magnitude") #idk what to put here
    
end 


#Plotting

holder_2 = Any[]

plot()
xlabel!("Frequency (Hz)")
ylabel!("Magnitude") #idk what to put here

for i in 1:3

	f = big_gauss[i]
	new_2 = dtft_coeff(f)
	push!(holder_2, new_2)
	plot!(sampled_freqs, abs.(new_2), xlim=(-2, 2), label="σ = $(sig_array[i])")

	
end


#plot(sampled_freqs, abs.(holder_2[1]))
savefig("gaussians_freq.png")



