using Plots
using FFTW

#Goal: Graph the DTFT of an input sinusoid

#Given a dt (time step) and total recording time, returns an array of times that a signal would be sampled at

function sampling_func(T,dt)
    
    sample_times=Float64[] #initialize empty array
    n=0 #counter

    while n*dt ≤ T
        
        append!(sample_times, [n*dt]) 
        n += 1
 
    end 
    
    return sample_times
    
        
end

T = 60
dt = 0.02 #48 Hz
sampling_func(T,dt)

#Given three arrays of the same length each containing values of amplitude A, angular frequency \omega, and phase \phi, along with an array of time steps t from part A, returns a discrete array of a sum of sinusoids with the specified parameters. I
#N.B.: Enter normal frequencies, not angular frequencies. The 2pi in newbie converts the frequency to angular frequency.

function newsignal(array_1, array_2, array_3, times)
    
    #Sinusoid format: A sin( 2 pi * \omega t + \phi)
    
    function sinusoid_array(array, times)
        
        holder = Float64[]
        
        for t in times
            newbie = [array[1]*sin(array[2]*2*pi*t+array[3])] #angular frequency info encoded in here
            append!(holder, newbie)
        
        end
        
    return holder
        
        
    end
    
    
    net_sinusoid = sinusoid_array(array_1, times) + sinusoid_array(array_2, times) + sinusoid_array(array_3, times)
    

    return net_sinusoid
    
end


array_1 = [1,2,-1]
array_2 = [4,7,0]
array_3 = [10,12,0]


#Calling fxn
times = sampling_func(T,dt)
newsignal(array_1, array_2, array_3, times)



#Returns the discrete Fourier transform coefficients of an input signal

function dtft_coeff(signal)
    
    return fftshift(fft([signal;zeros(500)])) #returns DTFT coefficients of input signal padded with 500 zeroes; fftshift puts 0 in middle of array
           
end

coeff = dtft_coeff(newsignal(array_1, array_2, array_3, times))
    

#Returns the frequencies that the discrete Fourier transform will be sampled at.

function f_freq(fs, num_pts)
    
    LinRange(-0.5*fs, 0.5*fs, num_pts) # all frequencies in given range that DFT is sampled at, from -Nyquist to +Nyquist
      
end
        
fs = 1/dt #sampling frequency
num_pts = length(times)+500 #+500 due to the zero-padding

sampled_freqs = f_freq(fs, num_pts)

#Returns a plot of the DFT of an input function
function DFT_plot(x,y)
    plot(x,y, title="DFT Plot", label = "DFT of sampled signal")
    xlabel!("Frequency (Hz)")
    ylabel!("Magnitude")
    
end 

#Plotting signal
DFT_plot(sampled_freqs, abs.(coeff))
savefig("oversampling_freq.png")

