using Plots
using FFTW
using STFT
using WAV
using DSP

#Makes spectrograms using different window sizes, intended for piano sample

#Loading audio

channels, sampling_rate = wavread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/Piano Sample.wav", format = "double") #signal encoded with double precision
sig = channels[:, 1] #channels is an NxC matrix where N = #length of audio samples, C = # of channels (C=1 for our purposes)
println("sampling freq: $sampling_rate Hz\n duration: $(round(length(sig) / sampling_rate, digits=2)) s")
println("number of samples:", length(sig))


#Spectrogram Code

#smaller window -> better time res, poorer freq res
window_len = 10
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate)
p1 = heatmap(spec.time, spec.freq, pow2db.(spec.power), xlabel = "Time (s)", ylabel = "Frequency (Hz)", clims = (-300, -10), guidefontsize=9)
#pow2db converts power to decibels; 10log_10(arg) (power of a signal has a specific definition)

#bigger window -> better freq res, poorer time res
window_len = 1000
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate)
p2 = heatmap(spec.time, spec.freq, pow2db.(spec.power), xlabel = "Time (s)", ylabel = "Frequency (Hz)", clims = (-300, -10), guidefontsize=9)


#even bigger window -> even better freq res, even poorer time res
window_len = 100000
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate)
p3 = heatmap(spec.time, spec.freq, pow2db.(spec.power), xlabel = "Time (s)", ylabel = "Frequency (Hz)", clims = (-300, -10), guidefontsize=9)

plot(p1,p2, p3, layout=(3,1))
savefig("spect_piano.png")

