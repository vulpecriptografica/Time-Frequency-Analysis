using Plots
using FFTW
using DSP
using Waveforms

#Goal: Apply a binary window filter to audio signal, plot original signal and filtered signal in time domain; expect to see Gibbs phenomenon due to binary window

#Plotting square wave in time
t = LinRange(0,10,1000)
sig = Waveforms.squarewave.(t)
sampling_rate = 0.02
p1 = plot(t, sig, size = (1000, 300), xlabel = "Time (s)",ylabel = "Amplitude", legend = false)


#Returns the discrete Fourier transform coefficients of an input signal
function dtft_coeff(signal)
    
    return fftshift(fft(signal))

           
end

#DFT coeffs
coeff = dtft_coeff(sig)

#Given an input of sampling frequency and number of points, return the frequencies that the discrete Fourier transform will be sampled at
function f_freq(fs, num_pts)
    
    LinRange(-0.5*fs, 0.5*fs, num_pts) # all frequencies in given range that DFT is sampled at
    
end

sampled_freqs = f_freq(sampling_rate, length(sig))

#Returns a plot of the DFT of an input function
function DFT_plot(x,y)

    plot(x,y, title="DFT Plot", label = "DFT of sampled signal")
    xlabel!("(Linear) Frequencies")
    ylabel!("Magnitude of Fourier coefficients") #idk what to put here
    
end 


#Filtering
filtermethod = Butterworth(16) #creating Butterworth filter of order 16
filter = digitalfilter(Lowpass(6, fs=fs), filtermethod) #creating lowpass filter, removes freqs above 6, w/ given sampling freq

timeSignal = filtfilt(filter, sig) #this is the time signal with the filter applied in the time domain
#filters twice, essentially, to remove phase distortion


#Plotting filtered square wave
p2 = plot(t, timeSignal, size = (1000, 300), xlabel = "Time (s)",ylabel = "Amplitude", legend = false)

#Plotting both square waves on one graph
plot(p1, p2, margin=6mm)
savefig("gibbs.png")





