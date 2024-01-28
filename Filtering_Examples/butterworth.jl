using Plots, Measures
using FFTW
using DSP

#Goal: Graph impulse response and frequency response of 16th-order Butterworth filter

#Given a dt (time step) and total recording time, returns an array of times that a signal would be sampled at.

function sampling_func(T,dt)
    
    sample_times=Float64[] #initialize empty array
    n=0 #counter

    while n*dt ≤ T
        
        append!(sample_times, [n*dt]) 
        n += 1
 
    end
    
    return sample_times
    
        
end

T = 50
dt = 0.005


#Returns the discrete Fourier transform coefficients of an input signal
function dtft_coeff(signal)
    
    return fftshift(fft([signal;zeros(500)])) #returns DTFT coefficients of input signal padded with 500 zeroes; fftshift puts 0 in middle of array
           
end

#Given an input of sampling frequency and number of points, return the frequencies that the discrete Fourier transform will be sampled at
function f_freq(fs, num_pts)
    
    LinRange(-0.5*fs, 0.5*fs, num_pts) # all frequencies in given range that DFT is sampled at
    
end
        
fs = 1/dt #sampling frequency
num_pts = length(times)+500 #+500 due to the zero-padding
sampled_freqs = f_freq(fs, num_pts) #samples in freq domain

#Returns a plot of the DFT of an input function
function DFT_plot(x,y)

    plot(x,y, title="DFT Plot", legend=false, xlims=(-15,15))
    xlabel!("Frequency (Hz)")
    ylabel!("Magnitude") #idk what to put here
    
end 

#Filtering
filtermethod = Butterworth(16) #creating Butterworth filter of order 16
filter = digitalfilter(Lowpass(6, fs=fs), filtermethod) #creating lowpass filter, removes freqs above 6, w/ given sampling freq

#creating signal
times = sampling_func(T,dt) #samples in time
signal = zeros(length(times))
idx = floor(Int64,length(times)/2)+1
signal = zeros(length(times))
signal[idx] = 1

#getting time domain signal after filter is applied
timeSignal = filtfilt(filter, signal) 
#this is the time signal with the filter applied in the time domain
#filters twice, essentially, to remove phase distortion


#Fourier transform time!
new_coeff = dtft_coeff(timeSignal) #get coeffs of dtft
plot(range(-25, 25, length(timeSignal)), timeSignal, xlims=(-3,3), xlabel="Time (s)", ylabel="Amplitude", legend=false)
savefig("butterworth_time.png")
DFT_plot(sampled_freqs, abs.(new_coeff))
savefig("butterworth_freq.png")


