using Plots
using FFTW
using STFT
using WAV
using DSP
using Measures


#Loading audio

channels, sampling_rate = wavread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/My Songs Know.wav", format = "double") #signal encoded with double precision
sig = channels[:, 1] #channels is an NxC matrix where N = #length of audio samples, C = # of channels (C=1 for our purposes)
println("sampling freq: $sampling_rate Hz\n duration: $(round(length(sig) / sampling_rate, digits=2)) s")
println("number of samples:", length(sig))


#Spectrogram Code 

window_len = 2000

#hann window, single spectrogram

spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate, window=hanning)
p4 = heatmap(spec.time, spec.freq, pow2db.(spec.power), title = "Spectrogram: Hann", xlabel = "Time (s)", ylabel = "Frequency (Hz)", xlims=(0,17), clims = (-70, -20), ylims = (0,5.0*10^3))

width,height = 1000, 600
plot(p4, size=(width,height), margin=4mm)
savefig("spect_one.png")


#graphing three spectrograms on one graph

#rectangular window
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate, window=rect)
p1 = heatmap(spec.time, spec.freq, pow2db.(spec.power), title="Spectrogram: Rectangular", xlabel="Time (s)", ylabel="Frequency (Hz)", xlims=(0,17), clims=(-150,-20), ylims = (0,5.0*10^3), margin=2mm)
#margin imposes margin on all subplots

#hamming window
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate, window=hamming)
p2 = heatmap(spec.time, spec.freq, pow2db.(spec.power), title = "Spectrogram: Hamming", xlabel = "Time (s)", ylabel = "Frequency (Hz)", xlims=(0,17), clims = (-150, -20), ylims = (0,5.0*10^3))


#hann(ing) window
spec = spectrogram(sig, window_len, window_len÷2, fs=sampling_rate, window=hanning)
p3 = heatmap(spec.time, spec.freq, pow2db.(spec.power), title = "Spectrogram: Hann", xlabel = "Time (s)", ylabel = "Frequency (Hz)", xlims=(0,17), clims = (-150, -20), ylims = (0,5.0*10^3))

width, height = 1000, 800
plot(p1,p2,p3,layout=(3,1), size=(width, height))
savefig("spect_window.png")


