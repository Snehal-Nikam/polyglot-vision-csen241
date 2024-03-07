from moviepy.video.VideoClip import TextClip
from moviepy.video.compositing.CompositeVideoClip import CompositeVideoClip
from moviepy.video.compositing.concatenate import concatenate_videoclips
from moviepy.video.io.VideoFileClip import VideoFileClip
from moviepy.video.tools.subtitles import SubtitlesClip


class video_subtitle( object ):

    def __init__(self):

        self.duration = 0.0
        self.transcription_words = 0
        self.translation_words = 0

        pass
    def generate_subtitles(self, clip, subtitlePath):
        subtitles = self.createSubtitles(subtitlePath)
        subtitles = self.setSubDuration(subtitles, clip.duration)
        return subtitles

    def createSubtitles(self, subtitlePath):
        generator = lambda txt: TextClip(txt, font='Amiri-Bold', fontsize=40, color='white')
        return SubtitlesClip(subtitlePath, generator)

    def setSubDuration(self, subtitles, duration):
        subtitles = subtitles.subclip(0, duration - .001)
        subtitles.set_duration(duration - .001)
        return subtitles

    def add_subtitle_to_video(self, clip, txtHI, txtEN):
        fontSize = clip.h * 0.05

        numberOfWordsHi = len(txtHI.split())
        self.translationWords += numberOfWordsHi

        mult = 2  #For calculating the position of subtitle

        if numberOfWordsHi > 9:
            auxHI = txtHI.split()
            auxHI.insert(8, '\n')

            mult = 4

            txtHI = " ".join(auxHI)

        numberOfWordsEn = len(txtEN.split())
        self.transcriptionWords += numberOfWordsEn

        if numberOfWordsEn > 9:
            auxEN = txtEN.split()
            auxEN.insert(8, '\n')

            txtEN = " ".join(auxEN)

        hindiTextClip = TextClip(txtHI, font='Amiri-Bold', fontsize=fontSize, color='white')
        englishTxtClip = TextClip(txtEN, font='Amiri-Bold', fontsize=fontSize, color='white')

        hindiTextClip = hindiTextClip.on_color(color=(20, 85, 33), col_opacity=0.8).set_pos(
            ("center", clip.h - mult * (fontSize + 2)))
        englishTxtClip = englishTxtClip.on_color(color=(0, 0, 0), col_opacity=0.8).set_pos(
            ("center", clip.h - (mult * 0.5) * (fontSize)))

        subtitledClip = CompositeVideoClip([clip, hindiTextClip, englishTxtClip])

        return subtitledClip.set_duration(clip.duration)

    def create_subtitled_video(self, fileName, originalPath, subtitlePathHI, subtitlePathEN, outputPath):
        print('*** create subtitled video ***')
        clip = VideoFileClip(originalPath)

        subtitles_hi = self.generate_subtitles(clip, subtitlePathHI).in_subclip(t_start=0, t_end=180)
        subtitles_en = self.generate_subtitles(clip, subtitlePathEN).in_subclip(t_start=0, t_end=180)

        annotatedClips = []
        self.transcriptionWords = 0
        self.translationWords = 0
        i = 0
        for ((fromTime, toTime), txt_hi), (_, txt_en) in zip(subtitles_hi, subtitles_en):
            if fromTime - i > 0:
                annotatedClips.append(clip.subclip(i + 0.00001, fromTime - 0.00001))

            annotatedClips.append(self.add_subtitle_to_video(clip.subclip(fromTime, toTime), txt_hi, txt_en))

            i = toTime

        final_clip = concatenate_videoclips(annotatedClips)
        final_clip.write_videofile(outputPath)
        return {'video_id': fileName, 'duration': clip.duration, 'transcriptionWords': self.transcriptionWords,
                'translationWords': self.translationWords}


