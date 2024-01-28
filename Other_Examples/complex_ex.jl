
#Goal: Graph sampled complex signal, then take Fourier transform and graph that too

using Plots
using FFTW

#given a dt (time step) and total recording time, returns an array of times that a signal would be sampled at

function sampling_func(T,dt)
    
    sample_times=Float64[] #initialize empty array
    n=0 #counter

    while n*dt ≤ T
        
        append!(sample_times, [n*dt]) #adds new sample to list of samples, then increases counter
        n += 1
 
    end 
    
    return sample_times
    
        
end

#Example values

T=50 #duration of signal
fs = 30 #sampling frequency
dt = 1/fs #time step

#Calling the fxn
sampling_func(T,dt)

#Specifying signal
times = sampling_func(T,dt)
y = 5 .*exp.(im.*2*pi*6 .*times) .+ 10 .*exp.(im.*2*pi*-12 .*times) #complex signal

#Using the outputs of parts A and B as inputs, create a function that plots a signal over time.

function signal_plot(x,y; label = "label")

    plot!(x,y, seriestype=:scatter, title="Plot (Connected)", label=label, linewidth=1, linecolor="magenta")
    xlabel!("Time")
    ylabel!("Amplitude")
    
end

x = sampling_func(T,dt)
plot()
signal_plot(x,real.(y); label = "Real")
signal_plot(x,imag.(y); label = "Imaginary")

#Create a function that returns the discrete Fourier transform coefficients of an input signal. You should use the fft and fftshift functions.

function dtft_coeff(signal)

    return fftshift(fft([signal;zeros(500)])) #returns DTFT coefficients of input signal padded with 500 zeroes; fftshift puts 0 in middle of array
           
end


coeff = dtft_coeff(y)

#Returns the frequencies that the discrete Fourier transform will be sampled at

function f_freq(fs, num_pts)
    
    LinRange(-0.5*fs, 0.5*fs, num_pts) #all frequencies in given range that DFT is sampled at
    
    
end
        
#fs = 1/dt #sampling frequency
num_pts = length(times)+500 #+500 due to the zero-padding

#Calling fxn
sampled_freqs = f_freq(fs, num_pts)#part six

#Returns a plot of the DFT of an input function

function DFT_plot(x,y)
    plot(x,y, title="DFT Plot", legend=false)
    xlabel!("Frequency (Hz)")
    ylabel!("Magnitude")
    
end 

#linear frequencies plot
lin_plot = DFT_plot(sampled_freqs, abs.(coeff))
savefig("complex_ex.png")


