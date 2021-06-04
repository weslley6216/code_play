require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    lesson = Lesson.create!(name: 'Primeira aula', content: 'Tipos primitivos', duration: 20, course: course)

    login_admin
    visit admin_course_path(lesson)

    within 'div#lessons' do
      expect { click_link 'Apagar' }.to change { course.lessons.count }.by(-1)
    end
    expect(page).to have_content('Aula removida com sucesso!')
    expect(current_path).to eq(admin_course_path(course))

  end
end